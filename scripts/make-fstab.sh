#!/bin/bash
# Script to automatically generate /etc/fstab

FORMAT="%-46s\t%-24s\t%-13s\t%-18s\t%-2s\t%-2s\n" # printf format

ROOT_UUID="d957d314-2629-418d-b1e5-64bc78d03a64"
SWAP_UUID="01098383-d26f-4fc3-a570-2fa65f767a0c"
SHARED_UUID="2b404128-4898-37a3-87e4-ea4a12bf1698"
HOME_UUID="176525c7-1bf1-425d-9745-e4ec860a4b0c"
MATLAB_UUID="ac479f9d-78d7-4066-b03a-86945c253d12"
MATLAB_UUID_TWO="e2620e77-ce61-4d93-8daa-4cf41056883d"
BOOT_UUID="cdfb3a53-d96f-4ea8-98f8-2559d4ae1e88"
BACKUP_UUID="81b7995d-8d94-4467-a160-f1dcffad7f9a"

UUIDS=( $ROOT_UUID $SWAP_UUID $SHARED_UUID $HOME_UUID $MATLAB_UUID $MATLAB_UUID_TWO $BOOT_UUID $BACKUP_UUID )
MTPTS=( "/" "none" "/mnt/shared" "/mnt/lhome" "/usr/local/MATLAB/R2014b" "/usr/local/MATLAB/R2009b" "/mnt/boot" "/mnt/backups/root" )
FORMATS=( "ext4" "swap" "hfsplus" "ext4" "ext4" "ext4" "ext2" "ext4" )
OPTIONS=( "errors=remount-ro" "sw" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,noauto" "rw,noauto" )
CHECKS=( "0 1" "0 0" "0 2" "0 2" "0 2" "0 2" "0 0" "0 0" )
COMMENTS=( "root partition" "swap" "shared partition" "linux home partition" "matlab 2014b partition" "matlab 2009b partition" "arch boot partition" "root backup partition" )


n=8

printf "# Begin /etc/fstab\n\n"

printf "# SYNTAX\n"
printf $FORMAT "# <partition>" "<mount point>" "<file system>" "<options>" '<dump>' '<pass>'
printf "\n"


for ((i=0;i<n;i++)); do
    printf "# ${COMMENTS[$i]}\n"
    printf $FORMAT "UUID=${UUIDS[$i]}" ${MTPTS[$i]} ${FORMATS[$i]} ${OPTIONS[$i]} ${CHECKS[$i]}
    printf "\n"
done

printf "# encrypted\n"
printf $FORMAT "/home/katie/.secret" "/home/katie/important" 		"ecryptfs" "noauto,user,rw,relatime,ecryptfs_sig=0094cbcb775e3ea4,ecryptfs_fnek_sig=0094cbcb775e3ea4,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_unlink_sigs" 	0 0

printf "\n\n"

printf "# End /etc/fstab\n"

