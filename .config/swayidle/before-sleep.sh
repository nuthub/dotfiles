#!/usr/bin/env bash

~/.local/bin/lockscreen.sh
echo "$(date) before-sleep" >> ~/.swayidle.log
#bluetoothctl power off
#nmcli radio wwan off
