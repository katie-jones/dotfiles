#!/bin/bash
# Script to automatically generate /etc/fstab

FORMAT="%-46s\t%-24s\t%-13s\t%-18s\t%-2s\t%-2s\n" # printf format

ROOT_UUID=""
SWAP_UUID="01098383-d26f-4fc3-a570-2fa65f767a0c"
HOME_UUID="176525c7-1bf1-425d-9745-e4ec860a4b0c"
SCHOOL_UUID="012013ff-ff66-4904-92e7-7a81a30a5a2a"
MEDIA_UUID="500C-AFE1"
CLOUD_UUID="5b9cbf51-b55c-4a14-8653-2e0153a8f865"
SHARED_UUID="47a4ee95-9221-4e37-850f-1c515365a3a9"
MATLAB_UUID="ac479f9d-78d7-4066-b03a-86945c253d12"
MATLAB_UUID_TWO="e2620e77-ce61-4d93-8daa-4cf41056883d"
BOOT_UUID="cdfb3a53-d96f-4ea8-98f8-2559d4ae1e88"
BACKUP_UUID="b60d83ea-e547-47f3-95da-7ef63bdb02c2"
BACKUP_HOME_UUID="3e41cb52-f707-4186-8f68-b1a2da0d8b3f"
BACKUP_SHARED_UUID="65f48282-7e11-43d8-b962-dc34bd27d5be"
BACKUP_MEDIA_UUID="8635b56c-bdb3-4591-a4ba-efadc392e638"
USB_UUID="7ECD-DEAD"
BOOTLOADER_UUID="8352ce51-8d4a-3f7c-b93c-bd8a6c498c87"


UUIDS=(
$ROOT_UUID
$SWAP_UUID
$HOME_UUID
$SCHOOL_UUID
$MEDIA_UUID
$CLOUD_UUID
$SHARED_UUID
$MATLAB_UUID
$MATLAB_UUID_TWO
$BOOT_UUID
$BACKUP_UUID
$BACKUP_HOME_UUID
$BACKUP_SHARED_UUID
$BACKUP_MEDIA_UUID
$USB_UUID
$BOOTLOADER_UUID
)

MTPTS=(
"/"
"none"
"/home"
"/home/katie/school"
"/mnt/media"
"/mnt/cloud"
"/mnt/shared"
"/usr/local/MATLAB/R2014b"
"/usr/local/MATLAB/R2009b"
"/boot"
"/mnt/backups/root"
"/mnt/backups/home"
"/mnt/backups/shared"
"/mnt/backups/media"
"/mnt/usb"
"/mnt/efi"
)

FORMATS=(
"ext4"
"swap"
"ext4"
"ext4"
"exfat"
"ext4"
"ext4"
"ext4"
"ext4"
"ext2"
"ext4"
"ext4"
"ext4"
"ext4"
"exfat"
"hfsplus"
)

OPTIONS=(
"errors=remount-ro"
"sw"
"rw,exec,auto"
"rw,exec,auto"
"rw,exec,auto"
"rw,exec,auto"
"rw,exec,auto"
"rw,exec,auto"
"rw,exec,auto"
"rw,auto"
"rw,noauto"
"rw,noauto"
"rw,noauto"
"rw,noauto"
"user,noexec,noauto"
"rw,noauto"
)

CHECKS=(
"0 2"
"0 0"
"0 2"
"0 2"
"0 2"
"0 2"
"0 2"
"0 2"
"0 2"
"0 1"
"0 0"
"0 0"
"0 0"
"0 0"
"0 0"
"0 0"
)

COMMENTS=(
"root partition"
"swap"
"linux home partition"
"school partition"
"media partition"
"cloud partition"
"shared partition"
"matlab 2014b partition"
"matlab 2009b partition"
"arch partition"
"root backup partition"
"home backup partition"
"shared backup partition"
"media backup partition"
"usb drive"
"linux bootloader partition"
)

n=16

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

