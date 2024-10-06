#!/bin/sh

# env
sed --in-place --follow-symlinks 's/export GTK_THEME=Adwaita:light/export GTK_THEME=Adwaita:dark/g' ~/.zprofile

# gesttings
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-Dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# alacritty
sed --in-place --follow-symlinks 's/modus-operandi/modus-vivendi/g' ~/.config/alacritty/alacritty.toml

# emacs
sed --in-place --follow-symlinks 's/(load-theme '\''modus-operandi t)/(load-theme '\''modus-vivendi t)/g' ~/.emacs.d/README.org 
emacsclient -e '(load-theme '\''modus-vivendi t)'
