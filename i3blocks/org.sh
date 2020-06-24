#!/bin/bash

# 1st row: full text
echo "org"

# 2nd row: short text
echo "org"

# 3rd row: color
echo "#FFFFFF"

cd ~ && emacsclient -nc --eval '(org-agenda-list)' '(delete-other-windows)' &2>/dev/null
 exit 0

