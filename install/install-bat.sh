#!/usr/bin/env bash

BAT_CONFIG_DIR="$XDG_CONFIG_HOME/bat"

rm -rf "$BAT_CONFIG_DIR"

ln -sf "$DOTFILES/bat" "$BAT_CONFIG_DIR"
