#!/bin/sh

load=$(uptime |sed 's/,//g' |awk '{print $8" "$9" "$10}')

# 1st row: Full text
echo " $load"
# 2nd row: Short text
echo " $load"
# 3rd row: color
comparison=$(echo $load | awk '{print $1}')" > 1"
if [ $(echo "${comparison}" | bc -l) -eq 1 ]; then
    echo "#FF8000"
fi
