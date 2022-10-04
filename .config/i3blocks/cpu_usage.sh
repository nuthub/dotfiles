#!/bin/sh

idle=$(mpstat 1 1 | tail -n1 | awk '{ print $NF }')
usage=$(echo "100-$idle" | bc)

# 1st row: full text
echo " $usage %"

# 2nd row: short text
echo " $usage %"

# 3rd row: color
if [ $(echo "${usage} > 15" | bc -l) -eq 1 ]; then
    echo "#FF8000"
fi

exit 0

