#!/bin/sh
nmcli connection show --active --order type:name \
    | grep -v 'NAME\|lo\|docker\|virbr0' \
    | awk '{ print $1 }' | paste -sd "|"
