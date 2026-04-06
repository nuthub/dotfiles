#!/bin/sh

command=$(echo "l: lockscreen
s: suspend
P: poweroff
R: reboot
e: logout" | rofi \
		 -dmenu \
		 -matching regex \
		 -no-tokenize \
		 -auto-select \
		 -filter '^' \
		 -theme-str 'window {width: 200px;}')

case $command in
    "l: lockscreen")
	lockscreen.sh
	exit 0
	;;
    "s: suspend")
	loginctl suspend
	exit 0
	;;
    "P: poweroff")
	loginctl poweroff
	exit 0
	;;
    "R: reboot")
	loginctl reboot
	exit 0
	;;
    "e: logout")
	#loginctl terminate-user $USER
	case $XDG_CURRENT_DESKTOP in
	    "sway")
		swaymsg exit
		exit 0
		;;
	    *)
		niri msg action quit -s
		exit 0
		;;
	esac
esac
	  

