#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# change bash prompt
# PS1='\[\e[0;34m\]\u \W > \[\e[0m\]'
PS1='\[\033[0;34m\]\u \W > \[\033[00m\]'

# alias for common grub commands
alias mkgrubcfg='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkgrubsa='sudo grub-mkstandalone -o boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg'
alias mkgrubsa_arch='sudo grub-mkstandalone -o boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /mnt/boot/grub/grub.cfg'


# function for ecryptfs
mtecrypt() {
    ecryptfs-insert-wrapped-passphrase-into-keyring /home/katie/.ecryptfs/wrapped-passphrase
    mount -i /home/katie/important
}

export EDITOR=vim
export MAKEFLAGS='-j2'

# export gopath
export GOPATH=$HOME/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH

# linker library path for new version of gcc
export LD_LIBRARY_PATH=/usr/local/lib64

# Solarized colors in console
source ~/.solarized_dark

# Add MATLAB to path
MATLABPATH=/usr/local/MATLAB/R2014b/bin
export PATH=$PATH:$MATLABPATH

# visual bell
set bell-style visible

# run system update
update_system() {
    sudo aptitude update && sudo aptitude dist-upgrade
}

# restart network manager
netman_restart() {
    sudo kill $(ps aux | grep NetworkManager | head -1 | gawk '{ print $2 }')
}

# global latexmk rc file
export LATEXMKRC=/usr/local/share/latexmk/latexmkrc
