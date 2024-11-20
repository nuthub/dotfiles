#!/usr/bin/env bash

# to test the script for mcron, use a --pure shell, e.g.:
# > guix shell --pure bash vdirsyncer emacs grep gawk -- ~/.local/bin/sync-calendars.sh

# the following is needed, if sync should happen with system's mcron
# cd /home/flake
# export SSL_CERT_DIR=/run/current-system/profile/etc/ssl/certs
# export XDG_RUNTIME_DIR=/run/user/1000

help() {
    # Display Help
    echo "Sync calendars and contacts."
    echo
    echo "Syntax: $0 [options]"
    echo 
    echo "options:"
    echo "-f  Full sync (includes discovering and metasyncing)"
    echo "-l  Light sync (excludes discovering and metasyncing)"
    echo "-h  Print this Help."
    echo
}

case $1 in
    "-f")
	vdirsyncer discover
	vdirsyncer metasync
	;;
    "-l")
	vdirsyncer sync
	emacs --init-directory=~/minimal-khalel  --batch --script minimal-khalel/init.el -e 'khalel-import-events'
	emacsclient -e '(jf/revert-file-visiting-buffer "~/org/calendar.org")'
	;;
    *)
	help
	exit 0
	;;

esac
