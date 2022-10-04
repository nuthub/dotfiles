#!/bin/sh

# der neue MQTT-Server:
mosquitto_sub -h mqtt.c3re.de -C 1 -t "c3re/hhdst" 
