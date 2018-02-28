#!/bin/bash

WIDTH="$1"
HEIGHT="$(echo "$WIDTH" | bc)"
BOOTANIOUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

IMAGESCALEWIDTH="$IMAGEWIDTH"
IMAGESCALEHEIGHT=$(expr $IMAGESCALEWIDTH / 2)

IMAGEHEIGHT=$(expr $IMAGEWIDTH / 2)

RESOLUTION=""$IMAGEWIDTH"x"$IMAGEHEIGHT""

for part_cnt in 0 1 2
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt
done
tar xfp "vendor/bliss/bootanimation/bootanimation.tar" -C "$BOOTANIOUT/bootanimation/"
mogrify -resize $RESOLUTION -colors 250 "$BOOTANIOUT/bootanimation/"*"/"*".jpg"

# Create desc.txt
echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT" 25 > "$BOOTANIOUT/bootanimation/desc.txt"
cat "vendor/bliss/bootanimation/desc.txt" >> "$BOOTANIOUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$BOOTANIOUT/bootanimation"

zip -qr0 "$BOOTANIOUT/bootanimation.zip" .
