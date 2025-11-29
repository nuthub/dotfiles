#!/bin/sh
cd ~/opt/tor-browser
guix shell \
    --container --emulate-fhs --network \
    --share=$HOME \
    --preserve='^WAYLAND_DISPLAY$|^XDG_RUNTIME_DIR$' --expose=$XDG_RUNTIME_DIR \
    --preserve='^DBUS_' --expose=/var/run/dbus \
    -e '(list (@@ (gnu packages commencement) gcc) "lib")' \
    alsa-lib bash coreutils dbus-glib file grep gtk+ libcxx pciutils sed \
    -- ./start-tor-browser.desktop -v
