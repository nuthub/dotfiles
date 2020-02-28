#!/bin/bash

UPTIME=$(uptime -p)

# 1st row: full text
echo " $UPTIME"

# 2nd row: short text
echo " $UPTIME"

# 3rd row: color
#[ ${STATUS} == 1 ] && echo "#80FF00"

exit 0

