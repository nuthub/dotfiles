#!/bin/sh

# to install a new astah version, download ZIP file, according to https://astah.net/support/how-to-run-astah-on-linux/#others

guix shell \
     --container \
     --emulate-fhs\
     --share=$HOME \
     --network \
     --preserve='^DBUS_' --expose=/var/run/dbus \
     --preserve='^DISPLAY$' \
     --expose=/sys/dev --expose=/sys/devices --expose=/dev/dri \
     coreutils icedtea@3.19.0 \
     -- env _JAVA_AWT_WM_NONREPARENTING=1 /home/flake/Applications/astah_professional/astah -nojvchk





