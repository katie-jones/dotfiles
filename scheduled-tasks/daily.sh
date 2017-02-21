#!/bin/bash

# Update packages lists
pacman -Qqettn > /home/katie/linux-config/package-management/native.txt
pacman -Qqettm > /home/katie/linux-config/package-management/foreign.txt

# Update packer packages
/home/katie/linux-config/scripts/safe_updates.py packer
