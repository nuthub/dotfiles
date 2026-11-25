#!/bin/sh
guix shell --container --network --emulate-fhs \
     --preserve='^WAYLAND_DISPLAY$|^XDG_' --expose=$XDG_RUNTIME_DIR \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --share=$HOME \
     --development ungoogled-chromium \
     zlib coreutils gcc-toolchain\
     -- ~/opt/drawio/AppRun $@
