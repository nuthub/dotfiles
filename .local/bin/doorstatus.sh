#!/bin/sh

HOST="mqtt.c3re.de"
TOPIC="c3re/hhdst" # Präsenz-Schalter
TOPIC="c3re/hhdst-classic" # Door-Status
SYMBOL=⚒

help() {
    # Display Help
    echo
    echo "Show doorstatus."
    echo "Syntax: `basename $0` <option>"
    echo
    echo "If no option provided: shows $SYMBOL  if door open, else shows nothing"
    echo
    echo "Options:"
    echo "-h, --help      show this help"
    echo "-s, --string    for string status [open|closed]"
    echo "-n, --numeric   for numeric status [0|1]"
    echo
}


# der neue MQTT-Server:
value=$(mosquitto_sub -h mqtt.c3re.de -C 1 -t "c3re/hhdst")

case "$1" in
    "--help"|"-h")
	help
	exit 0
	;;
    "--numeric"|"-n")
	echo $value
	;;
    "--string"|"-s")
	if [ $value == 1 ]; then 
	    echo "open"
	else
	    echo "closed"
	fi
	;;
    "")
	if [ $value == 1 ]; then 
	    echo $SYMBOL
	fi
	;;
    *)
	help
	;;
esac
