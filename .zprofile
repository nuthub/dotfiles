# -*- shell-script -*-

# see https://guix.gnu.org/manual/en/html_node/Configuring-the-Shell.html

# Set up the system, user profile, and related variables.
source /etc/profile
# Set up the home environment profile.
# source ~/.profile
# not necessary, when GUIX home is not used

PATH=$HOME/.local/bin:$PATH
TERMINAL=alacritty
EDITOR=emacsclient
XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share

if [[ ! -S ${XDG_RUNTIME_DIR-$HOME/.cache}/shepherd/socket ]]; then
    shepherd &
fi

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND="1"
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export GDK_BACKEND=wayland # this makes emacs not start (without pgtk)
    #    export SDL_VIDEODRIVER=wayland
    #    export CLUTTER_BACKEND=wayland
    exec dbus-run-session -- sway
fi
