#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

# change bash prompt
PS1='\[\033[0;34m\]\u \W > \[\033[00m\]'

# use threading in make
export MAKEFLAGS='-j2'

# check sudo commands for aliases
alias sudo='sudo '

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/katie/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/home/katie/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/katie/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/home/katie/Downloads/google-cloud-sdk/completion.bash.inc'
fi
