#!/usr/bin/env bash

SKETCHYBAR_CONFIG_DIR="$XDG_CONFIG_HOME/sketchybar"

rm -rf "$SKETCHYBAR_CONFIG_DIR"

ln -sf "$DOTFILES/sketchybar" "$SKETCHYBAR_CONFIG_DIR"
