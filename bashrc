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
alias mkgrubfile='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkgrubsa='sudo grub-mkstandalone -o boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg'
alias mkarchgrub='sudo grub-localconfig -o /mnt/shared/bootfiles/grub.d/39_arch'

# function to generate standalone and copy it to /mnt/shared and boot folder
mkgrubcfg() {
    cp /mnt/shared/bootfiles/boot.efi /mnt/shared/bootfiles/boot.efi.old
    sudo grub-mkconfig -o /boot/grub/grub.cfg && \
    sudo grub-mkstandalone -o /mnt/shared/bootfiles/boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg && \
    sudo mount UUID=b801a995-2e0b-3440-bb4a-cacccb9e233c /mnt/efi && \
    sudo cp -v /mnt/shared/bootfiles/boot.efi /mnt/efi/System/Library/CoreServices/ &&
    sudo umount /mnt/efi
}



# function for ecryptfs
mtecrypt() {
    ecryptfs-insert-wrapped-passphrase-into-keyring /home/katie/.ecryptfs/wrapped-passphrase
    mount -i /home/katie/important
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
