#!/usr/bin/python3

import sys
import os
import traceback
import time
import subprocess
import argparse
import configparser
import datetime

class BackupManager:
    HISTORY_FILENAME = '/var/cache/ink/history'
    SYSTEM_CONFIG_FILENAME = '/etc/ink/inkrc'

    def __init__(self, args):
        self.args = args

        # Parse config from config file
        files_to_parse = []
        if len(self.args.config_filename) > 0:
            files_to_parse.append(self.args.config_filename)

        files_to_parse.append(self.SYSTEM_CONFIG_FILENAME)

        self.global_config = self.parse_config(files_to_parse)

        # Make log and history dirs
        try:
            os.makedirs(os.path.dirname(self.HISTORY_FILENAME))
        except FileExistsError:
            pass

    def run(self):
        history_writer = configparser.ConfigParser()

        # Loop through sections and run backups for each one
        for section in self.global_config.sections():
            config_section = self.global_config[section]
            config_section = self.check_config(config_section)

            # Make log and error directories
            try:
                os.makedirs(os.path.dirname(config_section.get('logfile')))
            except FileExistsError:
                pass
            try:
                os.makedirs(os.path.dirname(config_section.get('errfile')))
            except FileExistsError:
                pass

            # Open log and error files
            self.logfile = open(config_section.get('logfile'), 'w')
            self.errfile = open(config_section.get('errfile'), 'w')

            # Log which section we're running
            self.log('Date: {:s}'.format(
                self.get_current_time_formatted('%Y-%m-%d')), False)
            self.log('Running section {:s}'.format(section))

            # Run backups
            if self.run_backups(config_section, self.args):
                # If backups were successful, add an entry in the cache file
                history_writer.read_dict({section: {'last_backup':
                                                    int(time.time())}})
            # Close log and error files
            self.logfile.close()
            self.errfile.close()

        with open(self.HISTORY_FILENAME, 'w') as history_file:
            history_writer.write(history_file)

    @staticmethod
    def parse_config(files_to_parse):
        '''
        Parse config from a config file.
        '''
        parser = configparser.ConfigParser()
        parser.read_dict(BackupManager.get_default_config())
        parser.read(files_to_parse)
        return parser

    @staticmethod
    def check_config(config):
        '''
        Check the syntax of the config arguments.
        '''
        # Option 'to_backup' must be given
        if len(config.get('to_backup')) == 0:
            raise ValueError("The directory to backup (option 'to_backup') must be"
                             " given.")
        # Check that frequency is an int
        try:
            config.getint('frequency_seconds')
        except ValueError:
            raise ValueError("The frequency of the backups for '{:s}' (option "
                             "'frequency_seconds') was given as '{:s}', "
                             "which is not an int!".format(config.name,
                                 config.get('frequency_seconds')))

        # Set all directory arguments to have no trailing slash
        directory_args = ['mount_point', 'backup_folder', 'to_backup', 'link_name']
        for arg in directory_args:
            if config[arg][-1] == '/' and len(config[arg]) > 1:
                config[arg] = config[arg][:-1]

        return config

    @staticmethod
    def get_default_config():
        '''
        Return the default configuration as a dict, to be read using the
        ConfigParser's read_dict function.
        '''
        config = dict()
        config['DEFAULT'] = {'mount_point': '/mnt/backups',
                             'backup_folder': '%(mount_point)s',
                             'to_backup': '',
                             'exclude_file': '',
                             'UUID': '',
                             'partition_label': '',
                             'partition_device': '',
                             'logfile': '/var/log/ink/backups.log',
                             'errfile': '/var/log/ink/backups.err',
                             'link_name': 'current',
                             'folder_prefix': 'backup-',
                             'frequency_seconds': '{:d}'.format(60*60*24)
                            };
        return config

    def log(self, string, print_time = True):
        '''
        Log string to logfile.
        '''
        if print_time:
            self.logfile.write('[{:s}] '.format(
                self.get_current_time_formatted()))

        self.logfile.write(string + '\n')
        print(string)

    def errlog(self, string, print_time = True):
        '''
        Log string to errfile.
        '''
        if print_time:
            self.logfile.write('[{:s}] '.format(self.get_current_time_formatted()))

        self.errfile.write(string + '\n')
        print(string)

    @staticmethod
    def get_current_time_formatted(date_format = '%H:%M:%S'):
        return datetime.datetime.now().strftime(date_format)

    def run_backups(self, section, args):
        '''
        Run a backup based on a section of the config file corresponding to a
        backup of a single directory.
        '''

        # Run only if backup is outdate (needs to be run again) or if the force
        # option was given.
        if args.force_backup or self.backup_outdated(section):
            self.log('Making new backups.')
            # Mount the drive where the backups should go
            try:
                self.mount_drive(section)
            except RuntimeError as e:
                self.errlog('Error: ' + str(e))
                self.errlog('Exiting.')
                return

            # Make the backups
            try:
                self.make_backups(section)
                backups_made = True
            except Exception as e:
                self.errlog('An error occurred making the backups.')
                exc_type, exc_value, exc_traceback = sys.exc_info()
                traceback.print_exception(exc_type, exc_value, exc_traceback,
                              limit=2, file=self.logfile)
                traceback.print_exception(exc_type, exc_value, exc_traceback,
                              limit=2, file=sys.stdout)
                self.errlog(str(e))
                self.errlog(traceback.print_exception(e))
                backups_made = False
        else:
            backups_made = False

        return backups_made

    def backup_outdated(self, section_config):
        '''
        Return True if the last backup of the directory given in section_config is
        older than the specified frequency.
        '''
        self.log('Checking if backup is outdated...')
        # Read history from cache
        parser = configparser.ConfigParser()
        parser.read('/var/cache/ink/history')

        # Check if there is an entry for the given section
        try:
            section_history = parser[section_config.name]

            # Read epoch time of last backup
            last_backup = section_history.getint('last_backup', 0)
        except KeyError:
            last_backup = 0

        # Check if the last backup is too old
        return (int(time.time()) - last_backup) > \
           section_config.getint('frequency_seconds')

    def make_backups(self, section):
        # Get name of new backup folder
        new_backup_folder_base = os.path.join(section.get('backup_folder'),
                                   section.get('folder_prefix') + \
                datetime.datetime.now().strftime('%Y-%m-%dT%H:%M'))

        if section.get('to_backup')[0] == '/':
            self.log(section.get('to_backup')[1:])
            new_backup_folder = os.path.join(new_backup_folder_base,
                                             section.get('to_backup')[1:])
        else:
            new_backup_folder = os.path.join(new_backup_folder_base,
                                             section.get('to_backup'))

        self.log('New backup folder: ' + new_backup_folder)

        # Make sure new backup folder has a trailing slash
        if new_backup_folder[-1] != '/':
            new_backup_folder = new_backup_folder + '/'


        # Get name of previous (symlinked) backup folder
        symlink_latest_backup_folder = os.path.join(section.get('backup_folder'),
                                      section.get('link_name'))

        # Make directory to hold new backup
        n = 0
        while (1):
            if n > 0:
                tmp_folder_name = new_backup_folder + str(n)
            else:
                tmp_folder_name = new_backup_folder
            try:
                os.makedirs(tmp_folder_name)
                new_backup_folder = tmp_folder_name
                break
            except FileExistsError:
                n = n + 1
                continue

        # Set up rsync command
        shell_command = ['sudo', 'rsync', '-ax', '--log-file',
                         section.get('logfile')]

        # Check if symlink to previous backup exists
        if os.path.isdir(symlink_latest_backup_folder):
            shell_command.append('--link-dest=' + symlink_latest_backup_folder)

        # Check if exclude file given
        if len(section.get('exclude_file')) > 0 and \
           os.path.exists(section.get('exclude_file')):
            shell_command.append('--exclude-from=' + section.get('exclude_file'))

        # Add source and destination
        if section.get('to_backup') == '/':
            shell_command.extend([section.get('to_backup'), new_backup_folder])
        else:
            shell_command.extend([section.get('to_backup') + '/', new_backup_folder])

        # Run shell command
        self.log('Running shell command: ' + ' '.join(shell_command))
        p = subprocess.Popen(' '.join(shell_command), shell=True)
        p.communicate()

        # Check return code and raise error if command did not succeed
        if p.returncode != 0:
            raise RuntimeError('Making backups with rsync failed.')

        # Replace previous symlink
        try:
            os.unlink(symlink_latest_backup_folder)
        except FileNotFoundError:
            pass
        os.symlink(new_backup_folder_base, symlink_latest_backup_folder)

        self.log('Backups succeeded.')

    def mount_drive(self, section):
        '''
        Mount the partition where the backups should be made.
        '''
        self.log('Checking if partition is already mounted...')

        if not self.is_mounted(section.get('mount_point')):
            self.log('Partition not already mounted. Trying to mount it.')

            # Initialize basic command
            shell_command = ["sudo", "mount"]

            # Check UUID, label and device in that order
            if len(section.get('UUID')) > 0:
                shell_command.extend(['-U', section.get('UUID')])
            elif len(section.get('partition_label')) > 0:
                shell_command.extend(['-L', section.get('partition_label')])
            elif len(section.get('partition_device')) > 0:
                shell_command.append(section.get('partition_device'))

            # Add mount point of partition to shell arguments
            shell_command.append(section.get('mount_point'))

            # Mount device
            p = subprocess.Popen(' '.join(shell_command), shell=True)
            p.communicate()

            # Check return code and raise error if command did not succeed
            if p.returncode != 0:
                raise RuntimeError('Mounting backup disk failed.')

            self.log('Partition mounted.')
        else:
            self.log('Partition already mounted.')

    @staticmethod
    def is_mounted(desired_mount_point):
        partition_mounted = False
        with open('/proc/mounts') as mount_file:
            for line in mount_file:
                __, mount_point, __, flags, __, __ = line.split()
                if mount_point == desired_mount_point:
                    partition_mounted = True
                    break

        return partition_mounted

def main():
    args = parse_args(sys.argv[1:])
    backup_manager = BackupManager(args)
    backup_manager.run()

def parse_args(argv):
    '''
    Parse command line arguments.
    '''
    parser = argparse.ArgumentParser(description='Make local backups of disk.')
    parser.add_argument('config_filename', default = '', nargs = '?',
                        help='Path to configuration file.')
    parser.add_argument('-f', dest='force_backup', action='store_true',
                        help='Force backup regardless of time stamp')
    return parser.parse_args(argv)

if __name__ == "__main__":
    main()
