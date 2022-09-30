#!/bin/sh

# Retrieve doorstatus by some means (e.g. MQTT or spaceapi)
STATUS=$(~/.local/bin/doorstatus.sh)
if [ ${STATUS} == 1 ]; then STR="open"; else STR="closed"; fi

# 1st row: full text
echo "⚒ $STR"

# 2nd row: short text
echo "⚒ $STR"

# 3rd row: color
[ ${STATUS} == 1 ] && echo "#80FF00"

exit 0
