#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# change bash prompt
PS1='\[\e[0;34m\]\u \W > \[\e[0m\]'

# export gopath
export GOPATH=$HOME/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH
