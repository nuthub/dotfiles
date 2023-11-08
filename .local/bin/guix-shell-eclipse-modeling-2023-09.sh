#!/bin/sh


# There is a problem with Papyrus on 2023-09: https://www.eclipse.org/forums/index.php/t/1113675/
# and there is also a workaround: use 2023-06 update site instead of latest and 2023-09, which did not work for me

# Bug is fixed (Oct 2023), I was able to install a running version from http://download.eclipse.org/modeling/mdt/papyrus/updates/nightly/master

guix shell \
     --container \
     --emulate-fhs\
     --network \
     --preserve='^DISPLAY$' \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     --share=$HOME \
     coreutils glib gtk+ glibc glibc-locales libxtst adwaita-icon-theme webkitgtk openjdk@17.0.5:jdk xdg-utils bash firefox ungoogled-chromium \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 ~/Applications/eclipse/eclipse-modeling-2023-09/eclipse

