#!/usr/bin/python3

import ink
import argparse
import subprocess
import sys
import time

def main():
    # Arg 1 should always be the update type -- parsed by local parser
    update_args = parse_args(sys.argv[1:2])

    # Args after 1 should be parsed by the run_backups arg parser
    backup_manager = ink.BackupManager(sys.argv[2:])

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
