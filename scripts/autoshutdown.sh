#!/bin/bash

# monitor GPIO pin for shutdown signal

# export GPIO pin and set to input with pull-up
pin="22" # rPi GPIO3

echo $pin > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio$pin/direction
echo "high" > /sys/class/gpio/gpio$pin/direction

n=0

# wait for pin to go low and count 5 seconds
while [ true ]
do
    [ "$(cat /sys/class/gpio/gpio31/value)" == '0' ] && n=n+1
    if [ n -gt 4 ]; then
        echo "Raspberry Pi Shutting Down!"
        halt &
        exit 0
    fi
    sleep 1
done

