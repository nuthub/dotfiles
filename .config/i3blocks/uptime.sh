#!/bin/sh

UPTIME=$(uptime  | awk '{print $3}' | sed -E 's/,//')

# 1st row: full text
echo " $UPTIME up"

# 2nd row: short text
echo " $UPTIME up"

# 3rd row: color
#[ ${STATUS} == 1 ] && echo "#80FF00"

exit 0
