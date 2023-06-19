#!/bin/sh
guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^DISPLAY$' \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc glibc-locales libxtst adwaita-icon-theme webkitgtk openjdk@17.0.5:jdk xdg-utils bash grep git \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/idea-IU-231.9011.34/bin/idea.sh
