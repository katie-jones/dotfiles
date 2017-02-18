# Ubuntu
--------------------------------------------------

## Package Management

List all packages: 
```bash
apt-mark showmanual
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
