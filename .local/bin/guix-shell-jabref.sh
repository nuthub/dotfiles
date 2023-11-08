#!/bin/sh

# the portable version of JabRef contains a JRE, so the container doesn't need an additional JRE
# there is a bug with the menus, why one should use gtk2: https://github.com/JabRef/jabref/issues/5867

guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^XDG_' \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+@2.24.33 glibc glibc-locales libxtst adwaita-icon-theme webkitgtk xdg-utils xdg-user-dirs \
     -- env _JAVA_OPTIONS="-Djdk.gtk.version=2" _JAVA_AWT_WM_NONREPARENTING=1 GDK_DISPLAY=1 ~/Applications/JabRef/bin/JabRef

