guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc libxtst adwaita-icon-theme xdg-utils openjdk@11.0.17:jdk
#     --preserve='^XAUTHORITY$' \
    #	       --expose=$XAUTHORITY \
