#!/usr/bin/env bash
set -euo pipefail

# Expected:
#   DOTFILES=~/dots
#   VIMCONFIG=~/.config/nvim

mkdir -p "$(dirname "$VIMCONFIG")"

# Backup existing config if present
if [ -e "$VIMCONFIG" ] || [ -L "$VIMCONFIG" ]; then
  ts="$(date +%Y%m%d-%H%M%S)"
  mv "$VIMCONFIG" "${VIMCONFIG}.bak.${ts}"
fi

# Symlink the entire Neovim config directory
ln -s "$DOTFILES/nvim" "$VIMCONFIG"

echo "✔ Neovim config linked:"
echo "  $VIMCONFIG → $DOTFILES/nvim"
