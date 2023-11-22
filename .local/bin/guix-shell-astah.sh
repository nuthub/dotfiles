#!/bin/sh
export _JAVA_AWT_WM_NONREPARENTING=1
guix shell icedtea@3.19.0 \
     -- /home/flake/Applications/astah_professional/astah -nojvchk
