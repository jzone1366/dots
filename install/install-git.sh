#!/usr/bin/env bash
set -euo pipefail

ln -sf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

echo "✔ git config linked:"
echo "  $HOME/.gitconfig → $DOTFILES/git/gitconfig"
