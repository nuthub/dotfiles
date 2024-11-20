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

    echo "Setting color scheme to: $preference"
    gsettings set org.gnome.desktop.interface color-scheme $preference

    echo "Setting GTK theme to: $gtk_theme"
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_theme
    sed --in-place --follow-symlinks "s/(\"GTK_THEME\" \. \".*\"/(\"GTK_THEME\" \. \"$gtk_theme\"/g" ~/.config/guix/home/home-configuration.scm 
    sed --in-place --follow-symlinks "s/GTK_THEME=\".*\"/GTK_THEME=\"$gtk_theme\"/g" ~/.config/guix/home/zsh/zprofile 

    echo "Setting icon theme to: $icon_theme"
    gsettings set org.gnome.desktop.interface icon-theme $icon_theme

    echo "Setting cursor theme to: $cursor_theme"
    gsettings set org.gnome.desktop.interface cursor-theme $cursor_theme
    swaymsg "seat seat0 xcursor_theme $cursor_theme"
    sed --in-place --follow-symlinks "s/seat seat0 xcursor_theme .*$/seat seat0 xcursor_theme $cursor_theme/g" ~/.config/sway/config

    # alacritty
    echo "Configuring Alacritty to use: $modus_theme"
    sed --in-place --follow-symlinks "s/import = \[\"~\/.config\/alacritty\/alacritty-themes\/.*\"\]/import = \[\"~\/.config\/alacritty\/alacritty-themes\/themes\/$modus_theme.toml\"\]/g" ~/.config/alacritty/alacritty.toml

    # emacs
    echo "Configuring Emacs to use: $modus_theme"
    sed --in-place --follow-symlinks "s/(load-theme '.* t)/(load-theme '$modus_theme t)/g" ~/.emacs.d/README.org 
    emacsclient --suppress-output --eval "(load-theme '$modus_theme t)"

    # reconfigure home
    echo "Reconfiguring Home environment"
    just guix-reconfigure-home
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
