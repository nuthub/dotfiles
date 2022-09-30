#!/bin/sh

ESSID=$(iwgetid -r)
if [ "x$ESSID" == "x" ] ; then ESSID="n/a"; fi
    
# Full (1st row) and short texts (2nd row)
echo " $ESSID"
echo " $ESSID"

# 3rd row: color
#[ ${STATUS} == 1 ] && echo "#80FF00"

exit 0
