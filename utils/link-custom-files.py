#!/usr/bin/python3

import os

def main():
    # Linux config directory
    linux_config_dir = '/home/katie/linux-config'

    # List files to link
    config_files = [{'file': 'custom-config/inkrc', 'destination':
                     '/etc/ink'}]

    # Loop through each file to create link
    for config in config_files:
        # Original file in dotfiles dir
        original_file = os.path.join(linux_config_dir, config['file'])

        # File name of symlink to be created
        symlink = os.path.join(config['destination'], os.path.basename(original_file))

        print('Symlinking {:s} -> {:s}...'.format(original_file, symlink))

        # Try to create symlink, handle error if file already exists
        try:
            os.symlink(original_file, symlink)
        except FileExistsError:
            try:
                # If the existing file is a symlink that points to the desired
                # dotfile -- nothing to do!
                if os.path.realpath(symlink) == original_file:
                    print('Symlink already exists! Nothing to do here.')
                    continue

                # Create a backup of the existing file
                backup_file = symlink + '.bk'
                print('File {:s} already exists. Backing up as {:s}...'\
                      .format(symlink, backup_file))

                # If the backup file already exists, exit
                if (os.path.exists(backup_file)):
                    print('Error: Backup file {:s} already exists. '
                          'Skipping this file.'.format(backup_file))
                    continue

                # Backup existing file
                os.rename(symlink, backup_file)

                # Create symlink
                os.symlink(original_file, symlink)
            except:
                print('An error occurred. Skipping this file.')
        except:
            print('An error occurred. Skipping this file.')

    print('Success!')

if __name__ == "__main__":
    main()

