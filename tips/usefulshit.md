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


