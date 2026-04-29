#!/usr/bin/env bash
cat  ~/.config/dunst/dunstrc-common ~/.config/dunst/dunstrc-light > ~/.config/dunst/dunstrc
dunstctl reload
