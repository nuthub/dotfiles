#!/bin/bash

VOL=$(amixer get Master | grep -m1 "[][]" | awk '{ print $5 }' | sed 's/\[//g' | sed 's/\]//')
MUTE=$(amixer get Master | awk '{ print $6 }' | grep -m1 "[][]"  | sed 's/\[//g' | sed 's/\]//')

# Full (1st row) and short texts (2nd row)
SYMBOL=""
[ ${VOL%?} -le 40 ] && SYMBOL=""
[ ${VOL%?} -le 20 ] && SYMBOL=""
echo "$SYMBOL $VOL ($MUTE)"
echo "$SYMBOL $VOL ($MUTE)"

# Set text color to green, if sound is unmuted
[ x${MUTE} == "xon" ] && echo "#80FF00"

exit 0
