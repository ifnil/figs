#!/usr/bin/env bash

# add theme to the rofi theme switcher
# different than setting it as the default
# to set it as the default, link the rofi dir

ROFI_THEME_DIR="$HOME/.local/share/rofi/themes"

mkdir -p "$ROFI_THEME_DIR"
ln -s "$HOME/figs/rofi/tiramisu.rasi" "$ROFI_THEME_DIR"
