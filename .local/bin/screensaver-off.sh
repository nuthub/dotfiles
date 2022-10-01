#!/bin/sh
xset -dpms
xset s off
killall -HUP xss-lock
# xset q
echo "xss-lock killed, dpms disabled"
