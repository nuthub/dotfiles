export ALTERNATE_EDITOR=""
export EDITOR=emacsclient
export VISUAL=emacsclient
export TERMINAL=alacritty
export BROWSER=firefox
export VIDEOPLAYER=mpv
export IMAGEVIEWER=sxiv
export PDFVIEWER=zathura
export QT_QPA_PLATFORMTHEME="qt5ct"

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
