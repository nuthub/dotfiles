#!/bin/sh
basename=`basename $1 .dot`
#dot -T ps2 $basename.dot -o $basename.ps
#epstopdf $basename.ps 
#rm $basename.ps
dot -Tsvg $basename.dot -o $basename.svg
inkscape -z -A $basename.pdf $basename.svg
rm $basename.svg
echo "done: $basename.dot -> $basename.pdf"

