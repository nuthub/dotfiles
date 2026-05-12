#!/usr/bin/env bash

sed --in-place -e 's/color_theme = ".*"/color_theme = "adwaita"/g' ~/.config/btop/btop.conf 
