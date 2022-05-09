#!/usr/bin/env bash

WEZTERM_CONFIG_DIR="$XDG_CONFIG_HOME/wezterm"

rm -rf "$WEZTERM_CONFIG_DIR"

ln -sf "$DOTFILES/wezterm" "$WEZTERM_CONFIG_DIR"
