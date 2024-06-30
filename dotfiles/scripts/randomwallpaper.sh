#!/usr/bin/env bash

set -e

WALLPAPER_DIR=~/.dotfiles/Wallpapers
cd $WALLPAPER_DIR

while 1
do
    RANDOM_FILE=$(ls |sort -R |tail -n1) 
    FULL_PATH="$WALLPAPER_DIR/$RANDOM_FILE"

    echo "Setting image to $FULL_PATH"

    env

    swww img "$FULL_PATH"
    sleep 5
done