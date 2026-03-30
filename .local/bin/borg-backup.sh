#!/bin/sh
##

failure=0

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
[[ $? -ne 0 ]] || failure=1

echo "Lösche alte Backups ..."
borg prune -v --list \
     --keep-daily 14 \
     --keep-monthly 6 \
     --keep-yearly 5
[[ $? -ne 0 ]] || failure=1

echo "Verdichte Repository"
borg compact --progress
[[ $? -ne 0 ]] || failure=1

echo "Stats ..."
borg info
[[ $? -ne 0 ]] || failure=1

echo "Report to Uptime Kuma ..."
[[ $failure -eq 0 ]] || curl -s -o /dev/null $KUMA_PUSH_URL

echo "###### Backup beendet: $(date) ######"
