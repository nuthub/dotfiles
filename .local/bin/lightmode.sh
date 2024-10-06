#!/bin/sh

# env
sed --in-place --follow-symlinks 's/export GTK_THEME=Adwaita:dark/export GTK_THEME=Adwaita:light/g' ~/.zprofile

# gsettings
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-Light'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

# alacritty
sed --in-place --follow-symlinks 's/modus-vivendi/modus-operandi/g' ~/.config/alacritty/alacritty.toml

# emacs
sed --in-place --follow-symlinks 's/(load-theme '\''modus-vivendi t)/(load-theme '\''modus-operandi t)/g' ~/.emacs.d/README.org 
emacsclient -e '(load-theme '\''modus-operandi t)'
