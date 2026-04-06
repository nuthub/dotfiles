#!/usr/bin/env bash

# dark / light mode
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' # 'Orchis-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# valid in light and dark
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface document-font-name='Noto Serif 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 11'
