#!/bin/sh

if [ ! "$1" = "hdd" -a ! "$1" = "ssh" ]; then
    echo "usage: `basename $0` [ssh|hdd]"
    exit 1
fi

export BORG_PASSPHRASE=$(pass borg/$1/passphrase)
export BORG_REPO=$(pass borg/$1/repo_url)
export KUMA_PUSH_URL=$(pass borg/$1/kuma_push_url)

if [ $1 = "hdd" -a ! -d $BORG_REPO ]
then
    echo "Externe Festplatte ist nicht angeschlossen!"
    exit 1
fi
failure=0


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
