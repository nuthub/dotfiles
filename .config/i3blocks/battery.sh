#!/bin/sh

BAT=$(acpi -b | grep -v unavailable | grep -E -o '[0-9]?[0-9][0-9]?%')
TIME=$(acpi -b | grep -v unavailable | grep -E -o '[0-9][0-9]:[0-9][0-9]')
STATE=$(acpi -b | grep -v unavailable | awk '{ print $3 }')

# Some symbols:      

SYMBOL=" "
[ ${BAT%?} -le 75 ] && SYMBOL=""
[ ${BAT%?} -le 25 ] && SYMBOL=""
[ ${BAT%?} -le 10 ] && SYMBOL=""

[ ${STATE} == "Full," ] || [ ${STATE} == "Charging," ] && SYMBOL+=" "
[ ${STATE} == "Discharging," ] && SYMBOL="  "
[ ! -z $TIME ] && TIME=" ($TIME)"

# Full (1st row) and short texts (2nd row)
echo "$SYMBOL$BAT$TIME"
echo "$SYMBOL$BAT$TIME"

# Set urgent flag below 5% or use orange below 20% 
[ ${BAT%?} -le 5 ] && exit 33
[ ${BAT%?} -le 20 ] && echo "#FF8000"
[ $STATE == "Charging," ] && [ ${BAT%?} -le 99 ] && [ ${BAT%?} -ge 21 ] && echo "#80FF00"

exit 0

