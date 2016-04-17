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

# function for ecryptfs
mtecrypt() {
    ecryptfs-insert-wrapped-passphrase-into-keyring /home/katie/.ecryptfs/wrapped-passphrase
    mount -i /home/katie/important
}


export EDITOR=vim

# export gopath
export GOPATH=$HOME/gopath

export PATH=$GOPATH:$GOPATH/bin:$PATH

