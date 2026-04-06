#!/usr/bin/env bash

# dark / light mode
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' # 'Orchis'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light'

# valid in light and dark
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface document-font-name='Noto Serif 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 11'
