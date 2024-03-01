#!/bin/sh

psfile=$1
pdffile=`basename $psfile .ps`.pdf
pdffilecropped=`basename $pdffile .pdf`-crop.pdf

ps2pdf $psfile
pdfcrop -clip  $pdffile
mv $pdffilecropped $pdffile
echo $pdffile
