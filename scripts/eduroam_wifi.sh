#!/bin/bash
sudo systemctl stop connman
sudo wpa_supplicant -B -Dnl80211 -iwlp3s0 -c/etc/wpa_supplicant/wpa_supplicant.conf 

