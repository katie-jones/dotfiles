#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# change bash prompt
PS1='\[\033[0;34m\]\u \W > \[\033[00m\]'

# use threading in make
export MAKEFLAGS='-j2'

# check sudo commands for aliases
alias sudo='sudo '

# alias for common grub commands
alias mkgrubcfgfile='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkgrubsa='sudo grub-mkstandalone -o /mnt/shared/bootfiles/boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg'

# function for ecryptfs
mtecrypt() {
    ecryptfs-insert-wrapped-passphrase-into-keyring /home/katie/.ecryptfs/wrapped-passphrase
    mount -i /home/katie/important
}

mkgrubcfg() {
    cp /mnt/shared/bootfiles/boot.efi /mnt/shared/bootfiles/boot.efi.old
    mkgrubcfgfile && \
    mkgrubsa && \
    sudo mount /mnt/efi && \
    sudo cp -v /mnt/shared/bootfiles/boot.efi /mnt/efi/System/Library/CoreServices/ &&
    sudo umount /mnt/efi
}


export EDITOR=vim

# export gopath
export GOPATH=$HOME/gopath

export PATH=$GOPATH:$GOPATH/bin:$PATH

# Solarized colors in console
source ~/.solarized_dark

# Add MATLAB to path
MATLABPATH=/usr/local/MATLAB/R2014b/bin
export PATH=$PATH:$MATLABPATH

# visual bell
set bell-style visible

# alias for pacman commands
alias pacup='pacman -Suy'
alias pacget='pacman -S'
alias pacdel='pacman -Runs'

# alias to open pdfs
alias opdf='ds qpdfview'
