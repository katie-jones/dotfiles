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

# alias for common grub commands
alias mkgrubcfgfile='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkgrubsa='sudo grub-mkstandalone -o /mnt/shared/bootfiles/boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg'

# function for ecryptfs
mtecrypt() {
    ecryptfs-insert-wrapped-passphrase-into-keyring /home/katie/.ecryptfs/wrapped-passphrase
    mount -i /home/katie/important
}

getpassword() {
    mounted=0
    [ -e $HOME/important/pw/sprd ] || { mtecrypt; mounted=1; }
    pw=$(gawk -v arg="$1" 'index($0,arg) { print $2 }' $HOME/important/pw/sprd)
    [ -n "$pw" ] \
    && { \
        echo "$pw" | xclip -sel clipboard; \
        echo "Password copied!"; } \
    || { \
        echo "Password for $1 not found..."; }
    [ "$mounted" -eq "1" ] && { echo "Unmounting partition..."; sleep 3; umount $HOME/important; }
}

getquestion() {
    mounted=0
    [ -e $HOME/important/pw/qus ] || { mtecrypt; mounted=1; }
    pw=$(gawk -v arg="$1" 'index($0,arg) { print $NF }' $HOME/important/pw/qus)
    [ -n "$pw" ] \
    && { \
        echo "$pw" | xclip -sel clipboard; \
        echo "Answer copied!"; } \
    || { \
        echo "Answer for $1 not found..."; }
    [ "$mounted" -eq "1" ] && { echo "Unmounting partition..."; sleep 3; umount $HOME/important; }
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/katie/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/home/katie/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/katie/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/home/katie/Downloads/google-cloud-sdk/completion.bash.inc'
fi
