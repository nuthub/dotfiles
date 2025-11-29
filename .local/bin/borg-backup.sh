#!/bin/sh
##

case "$1" in
    "hdd")
	source ~/.borg-credentials.hdd
	[ -d $BORG_REPO ] || { echo "Externe Festplatte ist nicht angeschlossen!" ; exit 1; }
	found=1
	;;
    "ssh")
	source ~/.borg-credentials.ssh
	found=1
	;;
esac

if [ ! $found ]
then
    echo "usage: `basename $0` [ssh|hdd]"
    exit 1
fi

echo "###### Backup gestartet: $(date) ######"
##
## do pre backup stuff here

##

echo "Übertrage Dateien ..."
borg create \
     --progress \
     --stats \
     ::'{now:%Y-%m-%d_%H:%M}'  \
     /home/flake      \
     --exclude-from /home/flake/.backupignore \
     --exclude-if-present .nobackup

echo "Lösche alte Backups ..."
borg prune -v --list \
     --keep-daily 14 \
     --keep-monthly 6 \
     --keep-yearly 5

echo "Stats ..."
borg info

echo "###### Backup beendet: $(date) ######"


