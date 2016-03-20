#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# change bash prompt
PS1='\[\e[0;34m\]\u \W > \[\e[0m\]'

# alias for common grub commands
alias mkgrubcfg='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkgrubsa='sudo grub-mkstandalone -o boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg'

export EDITOR=vim

# export gopath
export GOPATH=$HOME/gopath
TEXBIN=/usr/local/texlive/2015/bin/x86_64-linux

export PATH=$TEXBIN:$GOPATH:$GOPATH/bin:$PATH

