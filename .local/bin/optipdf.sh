#!/bin/bash

basename=`basename "$1" .pdf`
echo "${basename}.pdf"
ps2pdf "${basename}.pdf" "${basename}-optimized.pdf"

