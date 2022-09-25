#!/bin/sh

basename=`basename "$1" .pdf`

gs \
 -sOutputFile="${basename}-gray.pdf" \
 -sDEVICE=pdfwrite \
 -sColorConversionStrategy=Gray \
 -dProcessColorModel=/DeviceGray \
 -dCompatibilityLevel=1.4 \
 -dNOPAUSE \
 -dBATCH \
 "$1"
