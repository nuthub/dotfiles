#!/bin/sh

idle=$(mpstat 1 1 | tail -n1 | awk '{ print $NF }')
usage=$(echo "100-$idle" | bc)

# 1st row: full text
echo " $usage %"

# 2nd row: short text
echo " $usage %"

# 3rd row: color
usageInt=$(echo $usage | sed 's/\./ /' | awk '{ print $1 }')
[ ${usageInt} -ge 15 ] && echo "#FF8000"

exit 0

