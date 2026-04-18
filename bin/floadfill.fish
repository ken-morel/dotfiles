#!/usr/bin/fish
cp $argv[2] "/tmp/$argv[2]"
convert $argv[2] -alpha set -fill none -fuzz $argv[1] -draw "color 0,0 floodfill" $argv[2]
