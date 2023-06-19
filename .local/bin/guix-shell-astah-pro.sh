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
     coreutils glib gtk+ glibc libxtst adwaita-icon-theme xdg-utils openjdk@11.0.17:jdk firefox \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/astah_professional/astah -nojvchk

