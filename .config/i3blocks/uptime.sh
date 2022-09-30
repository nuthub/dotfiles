#!/bin/sh

UPTIME=$(uptime -p)
UPTIME=$(echo $UPTIME | sed 's/ week[s]\?,/w /')
UPTIME=$(echo $UPTIME | sed 's/ day[s]\?,/d /')
UPTIME=$(echo $UPTIME | sed 's/ hour[s]\?,/h /')
UPTIME=$(echo $UPTIME | sed 's/ minute[s]\?/m/')

# 1st row: full text
echo " $UPTIME"

# 2nd row: short text
echo " $UPTIME"

# 3rd row: color
#[ ${STATUS} == 1 ] && echo "#80FF00"

exit 0

