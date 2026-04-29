#!/usr/bin/env bash

ZELLIJ_CONFIG_DIR="$XDG_CONFIG_HOME/zellij"

mkdir -p "$ZELLIJ_CONFIG_DIR"

ln -sf "$DOTFILES/zellij/config.kdl" "$ZELLIJ_CONFIG_DIR/config.kdl"
