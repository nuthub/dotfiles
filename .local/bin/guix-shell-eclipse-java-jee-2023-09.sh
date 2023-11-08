#!/bin/sh


# Eclipse version downloaded from: https://ftp.halifax.rwth-aachen.de/eclipse/technology/epp/downloads/release/2023-09/R/eclipse-jee-2023-09-R-linux-gtk-x86_64.tar.gz

guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^DISPLAY$' \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc glibc-locales libxtst adwaita-icon-theme webkitgtk openjdk@17.0.5:jdk xdg-utils bash ungoogled-chromium \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/eclipse/eclipse-jee-2023-09/eclipse
