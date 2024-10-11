#!/bin/sh
nmcli connection show --active --order type:name \
    | grep -v 'NAME\|lo\|docker' \
    | awk '{ print $1 }' | paste -sd "|"
