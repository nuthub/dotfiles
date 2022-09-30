#!/bin/sh

FREE=$(awk '/MemFree/ { print $2 }'  /proc/meminfo)
GBFREE=$(awk '/MemFree/ { printf "%.2f\n", $2/1024/1024 }' /proc/meminfo)

# 1st row: Full text
echo "䷁ $GBFREE GB"
# 2nd row: Short text
echo "䷁ $GBFREE GB"
# 3rd row: Color
# 1GB=1048576
# 500MB=524288
[ ${FREE} -le 524288 ] && echo "#FF8000"

exit 0
