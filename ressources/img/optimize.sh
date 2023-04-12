#!/bin/bash
# for f in *.jpg; do
#     webpName="$(basename "$f" .jpg)".webp
#     # echo $f
#     # echo $webpName
    
#     magick $f -quality 66 big-66-$webpName
#     magick $f -quality 71 big-71-$webpName
#     magick $f -resize 1920x  -quality 66 fullhd-66-$webpName
#     magick $f -resize 1920x  -quality 71 fullhd-71-$webpName
# done;


for f in *.jpg; do
    echo "background-image url('img/$f')"
done;

for f in *.webp; do
    echo "background-image url('img/$f')"
done;
