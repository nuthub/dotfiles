#!/bin/sh
guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^DISPLAY$' \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc libxtst adwaita-icon-theme icedtea@3.19.0
#     --preserve='^XAUTHORITY$' \
    #	       --expose=$XAUTHORITY \
