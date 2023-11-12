# -*- shell-script -*-

# see https://guix.gnu.org/manual/en/html_node/Configuring-the-Shell.html

# Set up the system, user profile, and related variables.
source /etc/profile
# Set up the home environment profile.
# source ~/.profile
# not necessary, when GUIX home is not used

PATH=$HOME/.local/bin:$PATH
TERMINAL=alacritty
EDITOR=emacsclient -nc
XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    # not sure, what the next four are exactly needed for
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export GDK_BACKEND=wayland # this makes emacs not start (without pgtk)
    export MOZ_ENABLE_WAYLAND="1" # this makes firefox start wayland native
    exec dbus-run-session -- sway
fi
