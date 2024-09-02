#!/usr/bin/env bash

# to test the script for mcron, use a --pure shell, e.g.:
# > guix shell --pure bash vdirsyncer emacs grep gawk -- ~/.local/bin/sync-calendars.sh

cd /home/flake

export SSL_CERT_DIR=/run/current-system/profile/etc/ssl/certs
export XDG_RUNTIME_DIR=/run/user/1000

echo "NOW RUNNING vdirsyncer discover"
vdirsyncer discover
echo "NOW RUNNING vdirsyncer metasync"
vdirsyncer metasync
echo "NOW RUNNING vdirsyncer sync"
vdirsyncer sync
echo "NOW RUNNING (khalel-import-events)"
emacs --init-directory=~/minimal-khalel  --batch --script minimal-khalel/init.el -e 'khalel-import-events'
echo "NOW RUNNING (jf/revert-file-visiting-buffer)"
emacsclient -e '(jf/revert-file-visiting-buffer "~/org/calendar.org")'
