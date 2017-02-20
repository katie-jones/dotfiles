#!/usr/bin/python3

import run_backups
from run_backups import BackupManager
import subprocess
import sys

def main():
    args = run_backups.parse_args(sys.argv[1:])
    backup_manager = BackupManager(args)

    # Assume system backup is not up-to-date
    system_backup_status = 'not found'

    # Loop through sections to find full system backup
    for section in backup_manager.global_config:
        section_config = backup_manager.global_config[section]

        # Look for full system backup
        if section_config.get('to_backup') == '/':
            # Check if the backup is up-to-date
            if backup_manager.backup_outdated(section_config):
                system_backup_status = 'outdated'
            else:
                system_backup_status = 'up to date'

    if system_backup_status == 'not found':
        print('No full system backup was found. Not continuing with update.')
    elif system_backup_status == 'outdated':
        print('System backup is outdated. Not continuing with update.')
    else:
        print('System backup is up-to-date. Continuing with update.')
        shell_command = 'pacman -Suy --noconfirm'
        p = subprocess.Popen(shell_command, shell = True)
        p.communicate()
        if p.returncode == 0:
            print('Update succeeded.')
        else:
            print('Error occurred during update.')

if __name__ == "__main__":
    main()
