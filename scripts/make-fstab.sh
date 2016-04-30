#!/bin/bash
# Script to automatically generate /etc/fstab

FORMAT="%-46s\t%-24s\t%-13s\t%-18s\t%-2s\t%-2s\n" # printf format

ROOT_UUID="00fbd50f-7a98-48e8-a135-3b3ba00461c8"
SWAP_UUID="01098383-d26f-4fc3-a570-2fa65f767a0c"
SHARED_UUID="2b404128-4898-37a3-87e4-ea4a12bf1698"
SCHOOL_UUID="8e91e673-2782-3a44-b24c-a6112035cb4e"
HOME_UUID="176525c7-1bf1-425d-9745-e4ec860a4b0c"
MATLAB_UUID="ac479f9d-78d7-4066-b03a-86945c253d12"
MATLAB_UUID_TWO="e2620e77-ce61-4d93-8daa-4cf41056883d"
BOOT_UUID="cdfb3a53-d96f-4ea8-98f8-2559d4ae1e88"
SCHOOL_UUID="8e91e673-2782-3a44-b24c-a6112035cb4e"
HOME_BACKUP_UUID="3e41cb52-f707-4186-8f68-b1a2da0d8b3f"
BACKUP_UUID="62d583a4-3b9b-44a1-a5d0-f68fb8aeae38"

UUIDS=( $ROOT_UUID $SWAP_UUID $SHARED_UUID $SCHOOL_UUID $HOME_UUID $MATLAB_UUID $MATLAB_UUID_TWO $BOOT_UUID $BACKUP_UUID )
MTPTS=( "/" "none" "/mnt/shared" "/home/katie/school" "/mnt/lhome" "/usr/local/MATLAB/R2014b" "/usr/local/MATLAB/R2009b" "/mnt/boot" "/mnt/backups/root" )
FORMATS=( "ext4" "swap" "hfsplus" "hfsplus" "ext4" "ext4" "ext4" "ext2" "ext4" )
OPTIONS=( "errors=remount-ro" "sw" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,exec,auto" "rw,noauto" "rw,noauto" )
CHECKS=( "0 1" "0 0" "0 2" "0 2" "0 2" "0 2" "0 2" "0 0" "0 0" )
COMMENTS=( "root partition" "swap" "shared partition" "school partition" "linux home partition" "matlab 2014b partition" "matlab 2009b partition" "arch boot partition" "root backup partition" )

n=9

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

