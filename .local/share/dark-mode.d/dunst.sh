#!/usr/bin/env bash
cat  ~/.config/dunst/dunstrc-common ~/.config/dunst/dunstrc-dark > ~/.config/dunst/dunstrc
dunstctl reload
