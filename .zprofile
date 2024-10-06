# -*- shell-script -*-

# see https://guix.gnu.org/manual/en/html_node/Configuring-the-Shell.html

# Set up the system, user profile, and related variables.
source /etc/profile
# Set up the home environment profile (not necessary, when GUIX home is not used)
# source ~/.profile

# Guix profile (for packages installed by `guix package`)
export GUIX_PROFILE="/home/flake/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

export PATH=$HOME/.local/bin:$PATH
export TERMINAL=alacritty
export EDITOR="emacsclient -nc"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share

export GTK_THEME=Adwaita:dark

# FCC unlock my WWAN module
if [ -c /dev/wwan0mbim0 ]; then
    mbimcli -p -d /dev/wwan0mbim0 --quectel-set-radio-state=on
fi

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    ## set wayland relevant env variables
    ## some of the env variables are explained here: https://discourse.ubuntu.com/t/environment-variables-for-wayland-hackers/12750
    ## this is needed by desktop-portal-wlr, otherwise it doesn't feel responsible (see INFO output of `xdg-desktop-portal -v -l INFO`)
    export XDG_CURRENT_DESKTOP=sway
    ## export XDG_SESSION_DESKTOP=sway # not sure, what this is exactly needed for
    export QT_QPA_PLATFORM=wayland-egl
    ## this makes firefox start wayland native
    export MOZ_ENABLE_WAYLAND="1"
    ## this makes emacs start in wayland mode (requires pgtk)
    ## GDK_BACKEND should not be set anymore
    ## see https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
    # export GDK_BACKEND=wayland-egl
    ## Set JAVA_HOME to where java executable is available in the current profile
    export JAVA_HOME=$(builtin cd $(dirname $(readlink $(which java)))"/.."; pwd)
    ## Fix some Java GUIs
    export export _JAVA_AWT_WM_NONREPARENTING=1
    ## actually start sway with a dbus user session
    exec dbus-run-session -- sway > .sway.log 2>&1
fi

