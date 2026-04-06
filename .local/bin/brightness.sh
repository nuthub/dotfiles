#!/usr/bin/env bash

case $1 in
    "up")
	level=$(brightnessctl set 5%+ | sed -En 's/.*\(([0-9]+)%\).*/\1/p')
	;;
    "down")
	level=$(brightnessctl set 5%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p')
	;;
esac

notify-send -a "changeBrightness" \
	    -u low \
	    -i brightness-high \
	    -h string:x-dunst-stack-tag:brightness \
	    -h int:value:"$level" \
	    "Brightness: ${level}%"

