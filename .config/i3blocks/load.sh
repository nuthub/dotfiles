#!/bin/sh

LOAD=$(cat /proc/loadavg | awk '{print $1" "$2" "$2}')
LOAD1=$(cat /proc/loadavg | awk '{print $1}' | sed 's/\.//')

# 1st row: Full text
echo " $LOAD"
# 2nd row: Short text
echo " $LOAD"
# 3rd row: color
[ ${LOAD1} -ge 100 ] && echo "#FF8000"

