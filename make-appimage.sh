#!/bin/bash
set -e

APP=msupcm
VERSION=v1.0RC3

# 1. Compile normally with your main Makefile
make -C msupcm++ clean || true
make

# 2. Prepare AppDir
rm -rf AppDir
mkdir -p AppDir/usr/bin
mkdir -p AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons/hicolor

# Copy binary
cp msupcm++/msupcm AppDir/usr/bin/

# Create .desktop file
cat > AppDir/usr/share/applications/$APP.desktop <<EOF
[Desktop Entry]
Type=Application
Name=MSUPCMPLUSPLUS
Exec=msupcm
Icon=msupcm
Categories=AudioVideo;Utility;
EOF

# Copy icons from res/ if they exist, otherwise generate placeholder
ICON_SRC_DIR=res/icons/hicolor

if [ -d "$ICON_SRC_DIR" ]; then
    echo "Copying icons..."
    for SIZE_PATH in "$ICON_SRC_DIR"/*; do
        SIZE=$(basename "$SIZE_PATH") 
        SRC_APPS_DIR="$SIZE_PATH/apps"
        DST_APPS_DIR="AppDir/usr/share/icons/hicolor/$SIZE/apps"
        mkdir -p "$DST_APPS_DIR"
        for ICON_FILE in "$SRC_APPS_DIR"/*.png; do
            [ -f "$ICON_FILE" ] && cp "$ICON_FILE" "$DST_APPS_DIR/"
        done
    done
fi

# Generate placeholders if 256x256 does not exist
PLACEHOLDER_256="AppDir/usr/share/icons/hicolor/256x256/apps/msupcm.png"
if [ ! -f "$PLACEHOLDER_256" ]; then
    echo "Generating 256x256 placeholder icon..."
    mkdir -p "$(dirname "$PLACEHOLDER_256")"
    convert -size 256x256 xc:lightgray -gravity center \
        -pointsize 48 -draw "text 0,0 'MSU'" "$PLACEHOLDER_256"
fi

# 3. Package into AppImage
wget -c https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-x86_64.AppImage

./linuxdeploy-x86_64.AppImage \
    --appdir AppDir \
    --desktop-file AppDir/usr/share/applications/$APP.desktop \
    --icon-file AppDir/usr/share/icons/hicolor/256x256/apps/msupcm.png \
    --output appimage

