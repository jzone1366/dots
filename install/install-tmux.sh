#!/usr/bin/env bash

TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"

mkdir -p "$TMUX_CONFIG_DIR"

ln -sf "$DOTFILES/tmux/tmux.conf" "$TMUX_CONFIG_DIR"

#git clone https://github.com/tmux-plugins/tpm "$TMUX_CONFIG_DIR/plugins/tpm"
#"$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins"
