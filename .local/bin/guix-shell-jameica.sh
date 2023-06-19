#!/bin/sh
guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^XDG_' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc glibc-locales libxtst adwaita-icon-theme webkitgtk xdg-utils bash grep openjdk@17.0.5:jdk java-swt
##\
    #   -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/jameica/jameica/jameica.sh
