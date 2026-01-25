#!/usr/bin/env bash

# to test the script for mcron, use a --pure shell, e.g.:
# > guix shell --pure bash vdirsyncer emacs grep gawk -- ~/.local/bin/sync-calendars.sh

# the following is needed, if sync should happen with system's mcron
# cd /home/flake
# export SSL_CERT_DIR=/run/current-system/profile/etc/ssl/certs
# export XDG_RUNTIME_DIR=/run/user/1000

initdir=~/.config/emacs.minimal-khalel
calendarfile=
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
	vdirsyncer -v WARNING discover
	vdirsyncer -v WARNING metasync
	vdirsyncer -v WARNING sync
	#	emacs --init-directory=~/.config/emacs.minimal-khalel --batch  -e 'khalel-import-events'
	emacs --init-directory=$initdir --batch --script $initdir/init.el -e 'khalel-import-events'
	emacsclient -e '(jf/revert-file-visiting-buffer "~/org/agenda/calendar.org")'
	exit 0
	;;
    "-l")
	vdirsyncer -v WARNING sync
	emacs --init-directory=$initdir --batch --script $initdir/init.el -e 'khalel-import-events'
	emacsclient -e '(jf/revert-file-visiting-buffer "~/org/agenda/calendar.org")'
	exit 0
	;;
    *)
	help
	exit 0
	;;

esac
