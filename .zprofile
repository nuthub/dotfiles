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

export JAVA_HOME=$(guix build openjdk@21 | grep "\-jdk$")
export export _JAVA_AWT_WM_NONREPARENTING=1

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    # some are explained here: https://discourse.ubuntu.com/t/environment-variables-for-wayland-hackers/12750
    export XDG_CURRENT_DESKTOP=sway # this is needed by desktop-portal-wlr, otherwise it doesn't feel responsible (see INFO output of `xdg-desktop-portal -v -l INFO`)
    # export XDG_SESSION_DESKTOP=sway # not sure, what this is exactly needed for
    export QT_QPA_PLATFORM=wayland
    #    export QT_QPA_PLATFORMTHEME=qt5ct
    export GDK_BACKEND=wayland # this makes emacs not start (without pgtk)
    export MOZ_ENABLE_WAYLAND="1" # this makes firefox start wayland native
    exec dbus-run-session -- sway > .sway.log 2>&1
fi

