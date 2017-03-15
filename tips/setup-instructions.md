# Instructions for customizing a fresh Linux install

## Install programs
Install all programs using the package lists:
```bash
while read package; do
  sudo *INSTALL COMMAND* $package
done < package_list/packages.txt
```

## Dotfiles
Symlink all dotfiles into home directory: `./link-dotfiles.py`

## Terminal
Build and install st from repository: https://github.com/katie-jones/st.

Install tmux using package manager.

## Keyboard
To use caps lock as F13 (e.g. for a tmux prefix): build and install https://github.com/katie-jones/xkeyboard-config-f13.

Activate the 'caps:f13' option by:
1. running `setxkbmap -option caps:f13`; or
2. in the Deepin desktop environment: adding 'caps:f13' to the key com.deepin.dde.keyboard layout-options; or
3. in the GNOME desktop environment: adding 'caps:f13' to the key org.gnome.libgnomekbd.keyboard options.  

## Vim
### Vundle
Vundle is included as a submodule. Run `git submodule update --init --recursive` to install it. Once it is installed, open vim and run `:PluginInstall` to install all plugins.

### YouCompleteMe
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) is a code completion engine for vim. It requires a compiled component which must be manually built. This process is automated using the script `utils/build-ycm.sh`. The script is set up to use the system libclang binary (appropriate for Arch Linux) and to enable support for C and C++. For other language support see the documentation in the YCM git repository.
