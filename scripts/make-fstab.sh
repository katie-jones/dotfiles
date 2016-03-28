#!/bin/bash
# Script to automatically generate /etc/fstab

FORMAT="%-46s\t%-22s\t%-13s\t%-18s\t%-2s\t%-2s\n" # printf format

ROOT_UUID="d957d314-2629-418d-b1e5-64bc78d03a64"
SWAP_UUID="01098383-d26f-4fc3-a570-2fa65f767a0c"
SHARED_UUID="2b404128-4898-37a3-87e4-ea4a12bf1698"
HOME_UUID="176525c7-1bf1-425d-9745-e4ec860a4b0c"
MATLAB_UUID="ac479f9d-78d7-4066-b03a-86945c253d12"
BOOT_UUID="cdfb3a53-d96f-4ea8-98f8-2559d4ae1e88"

UUIDS=( $ROOT_UUID $SWAP_UUID $SHARED_UUID $HOME_UUID $MATLAB_UUID $BOOT_UUID )
MTPTS=( "/" "none" "/mnt/shared" "/mnt/lhome" "/usr/local/MATLAB" "/mnt/boot" )
FORMATS=( "ext4" "swap" "hfsplus" "ext4" "ext4" "ext2" )
OPTIONS=( "errors=remount-ro" "sw" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,noauto" )
CHECKS=( "0 1" "0 0" "0 2" "0 2" "0 2" "0 0" )
COMMENTS=( "root partition" "swap" "shared partition" "linux home partition" "matlab partition" "arch boot partition" )


n=6

printf "# Begin /etc/fstab\n\n"

printf "# SYNTAX\n"
printf $FORMAT "# <partition>" "<mount point>" "<file system>" "<options>" '<dump>' '<pass>'
printf "\n"


for ((i=0;i<n;i++)); do
    printf "# ${COMMENTS[$i]}\n"
    printf $FORMAT "UUID=${UUIDS[$i]}" ${MTPTS[$i]} ${FORMATS[$i]} ${OPTIONS[$i]} ${CHECKS[$i]}
    printf "\n"
done

printf "\n\n"
printf "# End /etc/fstab\n"

