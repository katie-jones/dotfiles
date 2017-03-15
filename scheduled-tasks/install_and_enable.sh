#!/bin/bash
# Script to install systemd timers and enable them
systemd_dir=/etc/systemd/system/
orig_dir=/home/katie/linux-config/scheduled-tasks/
root_script_dir=/usr/local/bin
services=("root-daily" "root-hourly" "katie-daily" "katie-hourly")
root_scripts=("root-daily" "root-hourly")

for unit in "${services[@]}"; do
    echo "Installing $unit..."
    sudo cp -v "$orig_dir$unit.service" "$orig_dir$unit.timer" "$systemd_dir"
    echo "Enabling $unit..."
    sudo systemctl enable "$unit.timer"
done

for script in "${root_scripts[@]}"; do
    echo "Installing $script..."
    sudo cp -v "$orig_dir$script.sh" "$root_script_dir"
done
