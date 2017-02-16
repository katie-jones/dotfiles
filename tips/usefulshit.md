# Ubuntu
--------------------------------------------------

## Package Management

List all packages: 
```bash
apt-mark showmanual
```

# Arch
--------------------------------------------------

## Package Management
List all native, manually installed packages:
```bash
pacman -Qqettn
```

List all non-native (e.g. AUR) manually installed packages:
```bash
pacman -Qqettm
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


Get disk usage of all (including hidden) directories:
```bash
du -ahd1 (directory) | sort -h
```
