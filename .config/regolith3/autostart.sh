#!/bin/bash

# Find all device IDs for the Magic Trackpad pointer
device_ids=$(xinput list | grep 'Apple Inc. Magic Trackpad' | grep -o 'id=[0-9]*' | cut -d= -f2)

# Loop through all matching device IDs and set the scrolling pixel distance
for device_id in $device_ids; do
    if [ -n "$device_id" ]; then
        echo "Setting scroll speed for device ID $device_id"
        xinput --set-prop "$device_id" "libinput Scrolling Pixel Distance" 30
    fi
done
