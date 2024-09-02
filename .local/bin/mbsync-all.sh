#!/usr/bin/env bash

# to test the script for mcron, use a --pure shell, e.g.:
# > guix shell --pure bash vdirsyncer emacs grep gawk -- ~/.local/bin/sync-calendars.sh

cd /home/flake

export SSL_CERT_DIR=/run/current-system/profile/etc/ssl/certs
export XDG_RUNTIME_DIR=/run/user/1000

echo "NOW RUNNING mbsync all"
mbsync all
