# Ubuntu
--------------------------------------------------

## Package Management

List all packages: 
```bash
apt-mark showmanual
```

List all packages installed manually:
```bash
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
```

# Vim
--------------------------------------------------

## Buffers
Perform a command in all buffers:
```vim
:bufdo (command)
```

Perform search on all lines containing XY, replacing abc with def
g/XY/ | s/abc/def/g

Copy all lines containing XY, then perform search on them, replacing XY with XZ.
g/XY/ copy . | s/XY/XZ/g

# Bash
--------------------------------------------------
Read file line by line:
```bash
while read line; do
  echo $line
done < myfile.txt
```

# Disk stuff
--------------------------------------------------
Safely erase hard drive:
`sudo shred -v -n1 -z /dev/sdX`

Print sorted list of all large, duplicate files in a directory (where 10000000 is the minimum size to print):
`fdupes -r -S --sameline . | paste -s -d' \n' | awk '$1 > 10000000' | sort -nr`

# Keyboard Layouts in Gnome
--------------------------------------------------

Enable all keyboard layouts: gsettings set org.gnome.desktop.input-sources show-all-sources true

# DigitalOcean Droplet Setup

1. Create droplet and add SSH key during create.
1. SSH into droplet as root.
1. Add new user account: `adduser myname`.
1. Add user to sudo group for sudo access: `usermod -aG sudo myname`.
1. Copy SSH authorized keys to new user: `mkdir /home/myname/.ssh && cp ~/.ssh/authorized_keys /home/myname/.ssh && chown -R myname:myname /home/myname/.ssh`.
1. Exit SSH session and reconnect as new user.
1. Disable root SSH access:
	a. Edit SSH config file: `sudo -e /etc/ssh/sshd_config`.
	a. Find line "PermitRootLogin yes" and change to "PermitRootLogin no".
	a. Restart SSH service: `sudo service ssh restart`.
