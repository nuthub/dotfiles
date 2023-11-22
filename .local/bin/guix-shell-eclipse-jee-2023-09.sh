#!/bin/sh
guix shell \
     --container --emulate-fhs --network \
     --share=$HOME \
     --preserve='^DISPLAY$' --expose=/dev \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/run/user \
     -e '(list (@@ (gnu packages commencement) gcc) "lib")' \
     coreutils zlib gtk+ webkitgtk \
     -- ~/Applications/eclipse/eclipse-jee-2023-09/eclipse
