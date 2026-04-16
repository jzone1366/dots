#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "sketchybar is macOS-only, skipping."
    exit 0
fi

SKETCHYBAR_CONFIG_DIR="$XDG_CONFIG_HOME/sketchybar"

rm -rf "$SKETCHYBAR_CONFIG_DIR"
ln -sf "$DOTFILES/sketchybar" "$SKETCHYBAR_CONFIG_DIR"

echo "✔ sketchybar config linked:"
echo "  $SKETCHYBAR_CONFIG_DIR → $DOTFILES/sketchybar"
