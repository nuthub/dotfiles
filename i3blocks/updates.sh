#!/bin/bash

UPDATES=$(checkupdates | wc -l)
[ ${UPDATES} == 0 ] && exit 0

# Full (1st row) and short texts (2nd row)
echo " $UPDATES updates"
echo " $UPDATES updates"

# Set urgent flag below 5% or use orange below 20% 
echo "#FF8000"

exit 0

