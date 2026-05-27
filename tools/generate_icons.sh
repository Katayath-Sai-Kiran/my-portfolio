#!/usr/bin/env bash
#!/usr/bin/env bash
# Generates PNG icons (192x192, 512x512) from all SVGs that match
# web/icons/favicon-*.svg
# Requires either: rsvg-convert (librsvg) or convert (ImageMagick)
set -euo pipefail
OUT_DIR=web/icons
mkdir -p "$OUT_DIR"

RASTER=""
if command -v rsvg-convert >/dev/null 2>&1; then
  RASTER="rsvg"
elif command -v convert >/dev/null 2>&1; then
  RASTER="magick"
fi

if [ -z "$RASTER" ]; then
  echo "No SVG rasterizer found. Install librsvg (rsvg-convert) or ImageMagick (convert)."
  echo "On macOS: brew install librsvg   OR   brew install imagemagick"
  exit 1
fi

echo "Rasterizer: $RASTER"

shopt -s nullglob
SVG_LIST=(web/icons/favicon-*.svg)
if [ ${#SVG_LIST[@]} -eq 0 ]; then
  echo "No favicon-*.svg files found in web/icons/."
  exit 1
fi

for SVG in "${SVG_LIST[@]}"; do
  base=$(basename "$SVG" .svg)
  out192="$OUT_DIR/${base}-192.png"
  out512="$OUT_DIR/${base}-512.png"
  echo "Generating $out192 and $out512 from $SVG"
  if [ "$RASTER" = "rsvg" ]; then
    rsvg-convert -w 192 -h 192 "$SVG" -o "$out192"
    rsvg-convert -w 512 -h 512 "$SVG" -o "$out512"
  else
    convert "$SVG" -resize 192x192 "$out192"
    convert "$SVG" -resize 512x512 "$out512"
  fi
done

echo "Generated PNGs for ${#SVG_LIST[@]} SVG variants in $OUT_DIR"
