#!/bin/sh


############################################################
# Help                                                     #
############################################################
help() {
    # Display Help
    echo "Switch between darkmode and lightmode."
    echo
    echo "Syntax: $0 [light|dark|help]"
    echo 
    echo "options:"
    echo "light    switch to light mode"
    echo "dark     switch to dark mode"
    echo "help     Print this Help."
    echo
}

switch() {
    echo "gtk theme: $gtk_theme"
    echo "icon theme: $icon_theme"
    echo "cursor theme: $cursor_theme"
    echo "modus theme: $modus_theme"

    ## Sway
    echo -n "Configuring sway" 
    # cursor    
    swaymsg "seat seat0 xcursor_theme $cursor_theme"
    sed --in-place --follow-symlinks "s/seat seat0 xcursor_theme .*$/seat seat0 xcursor_theme $cursor_theme/g" ~/.config/sway/config
    # gtk theme
    sed --in-place --follow-symlinks "s/export GTK_THEME=.*/export GTK_THEME=$gtk_theme/g" ~/.zprofile

    # gsettings
    echo "Configuring GTK (gsettings)"
    gsettings set org.gnome.desktop.interface color-scheme $preference
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_theme
    gsettings set org.gnome.desktop.interface icon-theme $icon_theme
    gsettings set org.gnome.desktop.interface cursor-theme $cursor_theme

    # alacritty
    echo "Configuring Alacritty"
    sed --in-place --follow-symlinks "s/import = \[\"~\/.config\/alacritty\/alacritty-themes\/.*\"\]/import = \[\"~\/.config\/alacritty\/alacritty-themes\/themes\/$modus_theme.toml\"\]/g" ~/.config/alacritty/alacritty.toml

    # emacs
    echo "Configuring Emacs"
    sed --in-place --follow-symlinks "s/(load-theme '.* t)/(load-theme '$modus_theme t)/g" ~/.emacs.d/README.org 
    emacsclient --suppress-output --eval '(load-theme '\''modus-vivendi t)'
}

case $1 in
    dark)
	preference="prefer-dark"
	cursor_theme="Bibata-Original-Classic"
	icon_theme="Papirus-Dark"
	gtk_theme="Materia-dark"
	modus_theme="modus-vivendi"
	switch
	;;
    light)
	preference="prefer-light"
	cursor_theme="Bibata-Original-Classic"
	icon_theme="Papirus-Light"
	gtk_theme="Materia-light"
	modus_theme="modus-operandi"
	switch
	;;
    *) # Invalid option
	help
	;;
esac
exit 0
