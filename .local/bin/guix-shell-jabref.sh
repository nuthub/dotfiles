#!/bin/sh
guix shell \
     --container --emulate-fhs --network \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^XDG_|^WAYLAND_DISPLAY$' --expose=/run/user \
     --preserve='^DISPLAY$' --expose=/dev/dri --expose=/sys/dev --expose=/sys/devices \
     --share=$HOME \
     coreutils gtk+ openjdk@17.0.5 xdg-utils xdg-user-dirs ungoogled-chromium \
     -- ~/Applications/JabRef-5.11/bin/JabRef
