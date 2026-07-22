#!/usr/bin/env bash

# adapted from https://github.com/Alexays/Waybar/issues/4328#issuecomment-3172305288

help() {
    echo "$0 <command>"
    echo "commands:"
    echo "  start"
    echo "  stop"
    echo "  toggle"
    echo "  status"
}

start() {
    #    wlsunset -l 51.6 -L 7.1 -d 900 -t 3500 -T 5700 &
    dex ~/.config/autostart/wlsunset.desktop
}

case "$1" in
    "start")
	if pkill -x -0 wlsunset; then
            pkill -x wlsunset
	else
	    start
	fi
	;;
    "stop")
	pkill -x wlsunset
	;;
    "toggle")
	if pkill -x -0 wlsunset; then
	    pkill -x wlsunset
	else
	    start
	fi
	;;
    "check")
	command -v wlsunset
	exit $?
	;;
    "help")
	help
	;;
esac

#Returns a string for Waybar
if pkill -x -0 wlsunset; then
    class="on"
    text="wlsunset is running"
else
    class="off"
    text="wlsunset is not running"
fi

printf '{"alt":"%s","tooltip":"%s"}\n' "$class" "$text"
