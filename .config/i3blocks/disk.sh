#!/bin/sh

DF=$(df -h / | grep "^/dev" | awk '{ print $4 }' | sed 's@\([0-9]\)G@\1@g')

# 1st row: Full text
echo "⛁ $DF GB"
# 2nd row: Short text
echo "⛁ $DF GB"
# 3rd row: Color
[ ${DF} -le 50 ] && echo "#FF8000"

exit 0
