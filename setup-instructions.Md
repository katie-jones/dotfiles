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
To use caps lock as tmux prefix: build and install https://github.com/katie-jones/xkeyboard-config-f13.

Activate the 'caps:f13' option by:
1. Running `setxkbmap -option caps:f13`
2. In the Deepin desktop environment: adding 'caps:f13' to the key com.deepin.dde.keyboard layout-options. 
3. In the GNOME desktop environment: adding 'caps:f13' to the key org.gnome.libgnomekbd.keyboard options.  
