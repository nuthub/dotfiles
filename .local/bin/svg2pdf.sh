#!/bin/sh
basename=`basename "$1" .svg`
inkscape --export-filename="$basename.pdf" "$basename.svg"
echo "done: $basename.svg -> $basename.pdf"
