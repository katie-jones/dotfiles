#!/bin/bash
INFILE=/home/katie/dotfiles/fstab.in
HOMEDIRS=( Documents Downloads Music Pictures Videos Public Templates )

cat $INFILE 

printf "\n\n\n"
echo "#-------------------------------------"
echo "#          bind mounts                "
echo "#-------------------------------------"
echo ""

for d in "${HOMEDIRS[@]}"
do
    printf "/mnt/lhome/katie/$d \t\t/home/katie/$d\tnone\tdefaults,bind\t0\t0\n"
done

