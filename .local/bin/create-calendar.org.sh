#!/usr/bin/env bash

# to test the script for mcron, use a --pure shell, e.g.:
# > guix shell --pure bash vdirsyncer emacs grep gawk -- ~/.local/bin/sync-calendars.sh

initdir=~/.config/emacs.minimal-khalel
emacs --init-directory=$initdir --batch --script $initdir/init.el -e 'khalel-import-events'
emacsclient -e '(jf/revert-file-visiting-buffer "~/org/agenda/calendar.org")'
