#!/bin/sh
guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc glibc-locales libxtst adwaita-icon-theme webkitgtk openjdk@17.0.5:jdk xdg-utils bash \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/eclipse/eclipse-modeling-2023-03/eclipse

