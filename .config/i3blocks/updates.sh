#!/bin/sh

# TODO: needs to be sudo to update root nix-channels
# TODO: There is an autoupgrade module

tempfile=/tmp/nixos-output
nixos-rebuild dry-build --upgrade &> $tempfile
UPDATES=$(cat $tempfile | grep derivations | awk '{print $2}')
rm $tempfile

[ "${UPDATES}" == "" ] && exit 0

# Full (1st row) and short texts (2nd row)
echo " $UPDATES updates"
echo " $UPDATES updates"

# Set urgent flag below 5% or use orange below 20% 
echo "#FF8000"

exit 0

