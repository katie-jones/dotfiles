#!/bin/bash
# Script to install systemd timers and enable them
systemd_dir=/etc/systemd/system/
services=("root-daily" "root-hourly" "katie-daily" "katie-hourly")

for unit in "${services[@]}"; do
    echo "Installing $unit..."
    sudo cp -v "$unit.service" "$unit.timer" $systemd_dir
    echo "Enabling $unit..."
    sudo systemctl enable "$unit.timer"
done
# sudo cp root-daily.service root-daily.timer
