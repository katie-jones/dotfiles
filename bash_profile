# customize prompt
export PS1='\[\033[0;36m\]\u\[\033[0;34m\] \W\[\033[m\] > '

# ls alias
alias ls='ls -GFh'

# eclimd alias
alias eclimstart='/Users/katie/Eclipse.app/Contents/Eclipse/eclimd &'

# eclipse cmake alias
alias eclcmake='cmake -G "Eclipse CDT4 - Unix Makefiles"'

# lint alias
alias lint='/Users/katie/Library/Android/sdk/tools/lint'

# switch to master thesis directory
alias thesiscd='cd /Users/katie/Dropbox/MasterThesis'

# set noclobber
set -o noclobber

# app shortcuts
alias prev='open -a Preview.app'
alias diffmerge='open -a DiffMerge.app'
alias app='open -a'
alias excel='app Microsoft\ Excel'

# generate random passwords
function pwgen() {
if [ "$1" = "-an" ]
then
	str="a-zA-Z0-9"
	in=$2
else
	str="a-zA-Z0-9-_\$\?\!\@\#"
	in=$1
fi
if [ -z $in ]
then
num=16
else
num=$in
fi
env LC_CTYPE=C tr -dc $str < /dev/urandom | head -c $num
echo
}


# attach/detach disk images
alias mnt='hdiutil attach'
alias umnt='hdiutil detach'


# open textedit
alias edit='open -a TextEdit.app'

# open passwords file
function openpw() {
if [ ! -d "/Volumes/lgp" ]; then
mnt "/Users/katie/lgp.dmg"
fi
edit /Volumes/lgp/pw
}

# set path
export PATH=/Users/katie/anaconda/bin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/Library/Android/sdk/platform-tools:$HOME/Scripts

