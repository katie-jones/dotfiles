#!/usr/bin/python3

import os

def main():
    # Get HOME directory
    home_dir = os.environ.get("HOME")
    if not home_dir:
        print('Error: No home directory found. Try setting the environment '
              'variable HOME and running the script again.')
        return

    # List files to link
    dotfiles = ["bashrc", 
                "latexmkrc", 
                "tmux.conf", 
                "vimrc", 
                "vim", 
                "xbindkeysrc"]

    # Get directory of dotfiles
    dotfiles_dir = os.path.dirname(os.path.realpath(__file__))

    # Loop through each file to create link
    for dotfile in dotfiles:
        # Original file in dotfiles dir
        original_file = os.path.join(dotfiles_dir, dotfile)

        # File name of symlink to be created
        symlink = os.path.join(home_dir, r'.' + dotfile)

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
