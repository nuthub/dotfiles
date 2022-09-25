export ALTERNATE_EDITOR=""
#export EDITOR=~/.local/bin/em # $EDITOR opens in terminal
export EDITOR=emacsclient
#export VISUAL=~/.local/bin/em # $VISUAL opens in GUI mode
export VISUAL=emacsclient
export TERMINAL=/usr/bin/urxvt
export BROWSER=/usr/bin/chromium
export VIDEOPLAYER=/usr/bin/mpv
export IMAGEVIEWER=/usr/bin/sxiv
export PDFVIEWER=/usr/bin/zathura
export QT_QPA_PLATFORMTHEME="qt5ct"

#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export XDG_CURRENT_DESKTOP=XFCE
#export XDG_CONFIG_DIRS=/etc/xdg

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private Application folder if it exists
if [ -d "$HOME/Applications" ] ; then
    PATH="$HOME/Applications:$PATH"
fi

# set PATH so it includes user's private ruby bin folder if it exists
if [ -d "$HOME/.local/share/gem/ruby/3.0.0/bin" ] ; then
    PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
fi


