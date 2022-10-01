#!/bin/sh
xset +dpms
xset s on
xss-lock --transfer-sleep-lock -- lockscreen &
# xset q
echo "xss-lock started, dpms enabled"
