#!/bin/sh

# annotator="flatpak run org.satty.Satty -f -"
annotator="swappy -f -"

help() {
    # Display Help
    echo "Take a screenshot."
    echo
    echo "Syntax: screenshot.sh [options]"
    echo 
    echo "options:"
    echo "-r  Take a region screenshot."
#    echo "-w  Take a window screenshot (requires sway, currently)."
    echo "-f  Take a fullscreen screenshot."
    echo "-h  Print this Help."
    echo
}

case $1 in
    "-r")
	grim -g "$(slurp -d)" - | $annotator
	exit 0
	;;
    # "-w")
    # 	swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | grim -g - - | $annotator
    # 	exit 0
    # 	;;
    "-f")
	grim - | $annotator
	exit 0
	;;
    *)
	help
	exit 0
	;;
esac

