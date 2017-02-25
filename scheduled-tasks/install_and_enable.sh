#!/bin/bash
# Script to install systemd timers and enable them
systemd_dir=/etc/systemd/system/
orig_dir=/home/katie/linux-config/scheduled-tasks/
services=("root-daily" "root-hourly" "katie-daily" "katie-hourly")

for unit in "${services[@]}"; do
    echo "Installing $unit..."
    sudo ln -sv "$orig_dir$unit.service" "$orig_dir$unit.timer" $systemd_dir
    echo "Enabling $unit..."
    sudo systemctl enable "$unit.timer"
done
