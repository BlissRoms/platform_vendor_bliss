#!/bin/bash

set -euo pipefail

IM="$(command -v magick || command -v convert || true)"
if [ -z "$IM" ] || [ -z "$(command -v pngcrush)" ]; then
    echo "Please install imagemagick and pngcrush"
    exit 1
fi

cd "$(dirname "$0")"

LOGO_DP=184
CANVAS_DP=192
TEXT_OFFSET_DP=155
TEXT_HEIGHT_DP=24
LOGO_RISE_DP=$(( (TEXT_OFFSET_DP + TEXT_HEIGHT_DP / 2 - LOGO_DP / 2) / 2 ))
TEXT_DROP_DP=$(( TEXT_OFFSET_DP - LOGO_RISE_DP ))

LEVEL_STEP=20
OUTLINE_GRAY="gray(8%)"
BLISS_BLUE="#05A7EC"
LOGO_SVG_PX=367

WOBBLE_FRAMES=8
WOBBLE_AMPLITUDE_DP=3
WOBBLE_CALM_CENTER=0.5
WOBBLE_WAVELENGTH=0.2
WOBBLE_WIDTH=0.3
WOBBLE_START=0.1
WOBBLE_TRAVEL=1.1

FONT_CELL_W_DP=22
FONT_CELL_H_DP=40
FONT_PT_DP=32
PERCENT_PT_DP=24
FONT_FIRST_CHAR=32
FONT_CHAR_COUNT=96
FONT="${FONT:-}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

px() {
    echo $(( ($1 * SCALE + 80) / 160 ))
}

sector_path() {
    awk -v pct="$1" -v d="$2" 'BEGIN {
        c = d / 2; r = d; a = pct * 3.6 * atan2(0, -1) / 180;
        x = c + r * sin(a); y = c - r * cos(a);
        printf "M %f,%f L %f,%f A %f,%f 0 %d,1 %f,%f Z", c, c, c, c - r, r, r, (pct > 50), x, y
    }'
}

render_logo() {
    local out="$1" pct="$2"
    local fill=(xc:"$OUTLINE_GRAY")

    if [ "$pct" -ge 100 ]; then
        fill=(xc:"$BLISS_BLUE")
    elif [ "$pct" -gt 0 ]; then
        fill=(xc:"$OUTLINE_GRAY" -fill "$BLISS_BLUE" -draw "path '$(sector_path "$pct" "$D")'")
    fi

    "$IM" -size "${W}x${H}" xc:black \
        "(" -size "${D}x${D}" "${fill[@]}" "$TMP/mask.png" -compose multiply -composite ")" \
        -geometry "+${LOGO_X}+${LOGO_Y}" -compose over -composite \
        -type TrueColor -depth 8 "png24:$out"
}

render_wobble() {
    local out="$1" still="$2" t="$3" center=$(( W / 2 ))

    "$IM" "$still" -virtual-pixel black -fx "
        dx = i - $center; dy = j - $center; dist = max(1, hypot(dx, dy));
        reach = dist / $(( D / 2 ));
        offset = reach - ($WOBBLE_START + $WOBBLE_TRAVEL * $t);
        shift = $(px "$WOBBLE_AMPLITUDE_DP") * sin(pi * $t) * min(1, reach / $WOBBLE_CALM_CENTER) * exp(-pow(offset / $WOBBLE_WIDTH, 2))
            * sin(2 * pi * offset / $WOBBLE_WAVELENGTH);
        p{i - shift * dx / dist, j - shift * dy / dist}" \
        -type TrueColor -depth 8 "png24:$out"
}

generate_scale() {
    local frames=() n i pct still wobble

    "$IM" -background black -density $(( 72 * D * 2 / LOGO_SVG_PX )) svg/logo.svg \
        -flatten -resize "${D}x${D}!" -colorspace gray "$TMP/mask.png"

    for (( pct = 0; pct <= 100; pct += LEVEL_STEP )); do
        still="$TMP/level_$(printf %03d "$pct").png"
        render_logo "$still" "$pct"
        frames+=("$still")
        for (( i = 1; i <= WOBBLE_FRAMES; i++ )); do
            wobble="$TMP/wobble_$(printf %03d "$pct")_$(printf %02d "$i").png"
            render_wobble "$wobble" "$still" "$(awk -v i="$i" -v n="$WOBBLE_FRAMES" 'BEGIN { print i / (n + 1) }')"
            frames+=("$wobble")
        done
    done

    n=${#frames[@]}

    # minui reads frames row-interleaved; side-by-side append reshaped to frame width yields that order.
    "$IM" "${frames[@]}" +append -depth 8 "rgb:$TMP/strip.rgb"
    "$IM" -size "${W}x$(( H * n ))" -depth 8 "rgb:$TMP/strip.rgb" -type TrueColor -strip "png24:$TMP/scale.png"
    pngcrush -q -noreduce -text b "Frames" "$n" "$TMP/scale.png" "$DPI/battery_scale.png"
}

font_glyph() {
    local out="$1" ch="$2" pt="$3"
    local placement=(-gravity center -annotate "+0+${TEXT_DROP}")
    if [ "$ch" = "%" ]; then
        ch="%%"
        placement=(-gravity west -annotate "+0+${TEXT_DROP}")
    fi
    "$IM" -size "${CW}x${CH}" xc:black -font "$FONT" -pointsize "$pt" -fill white \
        "${placement[@]}" "$ch" "$out"
}

generate_font() {
    local layers=() ch pt code glyph

    for ch in 0 1 2 3 4 5 6 7 8 9 %; do
        code=$(printf %d "'$ch")
        glyph="$TMP/glyph_$code.png"
        pt=$(px "$FONT_PT_DP")
        [ "$ch" = "%" ] && pt=$(px "$PERCENT_PT_DP")
        font_glyph "$glyph" "$ch" "$pt"
        layers+=("$glyph" -geometry "+$(( (code - FONT_FIRST_CHAR) * CW ))+0" -composite)
    done

    "$IM" -size "$(( FONT_CHAR_COUNT * CW ))x$(( 2 * CH ))" xc:black "${layers[@]}" \
        -colorspace gray -type Grayscale -depth 8 -strip "png:$DPI/percent_font.png"
}

for DENSITY in mdpi:160 hdpi:240 xhdpi:320 xxhdpi:480 xxxhdpi:640; do
    DPI=${DENSITY%%:*}
    SCALE=${DENSITY##*:}

    D=$(px "$LOGO_DP")
    W=$(( 2 * $(px $(( CANVAS_DP / 2 ))) ))
    H=$(( W + 2 * $(px "$LOGO_RISE_DP") ))
    LOGO_X=$(( (W - D) / 2 ))
    LOGO_Y=$LOGO_X

    "$IM" -background black -density "$SCALE" svg/battery_fail.svg \
        -flatten -resize "${SCALE}x${SCALE}" -type TrueColor -depth 8 -strip "png24:$DPI/battery_fail.png"

    generate_scale

    if [ -n "$FONT" ]; then
        TEXT_DROP=$(px "$TEXT_DROP_DP")
        CW=$(px "$FONT_CELL_W_DP")
        CH=$(( $(px "$FONT_CELL_H_DP") + 2 * TEXT_DROP ))
        generate_font
    fi

    echo "$DPI: ${W}x${H} frames"
done
