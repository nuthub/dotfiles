#!/bin/bash

BRI=$(xbacklight | sed 's/\./ /' | awk '{print $1}')"%"

# Full (1st row) and short texts (2nd row)
echo " $BRI"
echo " $BRI"

# 3rd row: color
#[ ${BRI%?} -le 5 ] && exit 33
#[ ${BRI%?} -le 20 ] && echo "#FF8000"

exit 0
