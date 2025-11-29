#!/bin/sh
guix shell --container --network --emulate-fhs \
     --share=$HOME \
     --preserve='^DISPLAY$' --expose=/dev/dri --expose=/sys/dev --expose=/sys/devices \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --development ungoogled-chromium \
     -e '(list (@@ (gnu packages commencement) gcc) "lib")' \
     zlib coreutils \
     -- ~/opt/drawio/AppRun $@
