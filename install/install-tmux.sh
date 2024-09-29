#!/usr/bin/env bash

TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"

mkdir -p "$TMUX_CONFIG_DIR"

ln -sf "$DOTFILES/tmux/tmux.conf" "$TMUX_CONFIG_DIR"
