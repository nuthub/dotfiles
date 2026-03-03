#!/bin/sh
video=$1
basename=$(basename "$video" .mp4)
ffmpeg  -i "$video" -r 1  -t 00:00:01 -vcodec png "$basename-%d.png"
mv "$basename-1.png" "$basename.png"
