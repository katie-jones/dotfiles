#!/usr/bin/python3

import argparse
import subprocess
import sys
import time
import importlib.util
import ink


def parse_args(argv):
    '''
    Parse command line arguments.
    '''
    parser = argparse.ArgumentParser(description='Update if backups are '
                                     'up-to-date.')
    parser.add_argument(
        'update_type',
        choices=['packer', 'pacman'],
        default='pacman',
        help='Type of update to perform (packer or pacman).')


def parse_args(argv):
    '''
    Parse type of update (official repos or packer) to run.
    '''
    parser = argparse.ArgumentParser(description='Run updates if an up-to-date'
                                     ' backup exists.')
    parser.add_argument(
        'update_type',
        action='store',
        choices=['packer', 'pacman'],
        help='Type of update to run (pacman or packer).')
    return parser.parse_args(argv)


def main():
    # Arg 1 should always be the update type -- parsed by local parser
    update_args = parse_args(sys.argv[1:2])

    # Args after 1 should be parsed by the run_backups arg parser
    backup_manager = ink.BackupManager(ink.parse_args(sys.argv[2:]))

    # Assume system backup is not up-to-date
    system_backup_status = 'not found'

    # Loop through sections to find full system backup
    print('Checking for up to date system backup...')
    for backup_instance in backup_manager.backup_instances:
        # Look for full system backup
        if backup_instance.to_backup == '/':
            system_backup_status = 'outdated'
            # Check if the backup is within 24 hours
            if backup_instance.last_backup > time.time() - 24 * 60 * 60:
                system_backup_status = 'up to date'
                break

    if system_backup_status == 'not found':
        print('No full system backup was found. Not continuing with update.')
        return 1
    elif system_backup_status == 'outdated':
        print('System backup is outdated. Not continuing with update.')
        return 1
    else:
        print('System backup is up-to-date. Continuing with update.')
        if update_args.update_type == 'pacman':
            print('Updating official repository packages.')
            shell_command = 'pacman -Suy --noconfirm'
        elif update_args.update_type == 'packer':
            print('Updating AUR packages.')
            shell_command = 'packer -Suy --auronly --noconfirm'
        else:
            print('Update type {:s} not recognized.'.format(
                update_args.update_type))
            return 1

        p = subprocess.Popen(shell_command, shell=True)
        p.communicate()
        if p.returncode == 0:
            print('Update succeeded.')
            return 0
        else:
            print('Error occurred during update.')
            return 1


if __name__ == "__main__":
    sys.exit(main())
