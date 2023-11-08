guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME=$HOME \
     coreutils findutils glib gtk+ glibc libxtst adwaita-icon-theme openjdk@17.0.5:jdk git bash which
