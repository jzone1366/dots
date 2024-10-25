#!/usr/bin/env bash

mkdir -p "$VIMCONFIG"

ln -sf "$DOTFILES/nvim/init.lua" "$VIMCONFIG"
ln -sf "$DOTFILES/nvim/filetype.lua" "$VIMCONFIG"

# Install all mandatory folders if they don't exist already
mkdir -p "$VIMCONFIG/backup"
mkdir -p "$VIMCONFIG/undo"
mkdir -p "$VIMCONFIG/swap"
mkdir -p "$VIMCONFIG/after"

# lua
rm -rf "$VIMCONFIG/lua"
ln -sf "$DOTFILES/nvim/lua" "$VIMCONFIG"

# after
rm -rf "$VIMCONFIG/after/ftplugin"
ln -sf "$DOTFILES/nvim/after/ftplugin" "$VIMCONFIG/after"

## UNCOMMENT BELOW WHEN YOU ADD THESE FILES
## macros
#rm -rf "$VIMCONFIG/macros"
#ln -sf "$DOTFILES/nvim/macros" "$VIMCONFIG/macros"
#
## compiler
#rm -rf "$VIMCONFIG/compiler"
#ln -sf "$DOTFILES/nvim/compiler" "$VIMCONFIG/compiler"
#
## indentation
#rm -rf "$VIMCONFIG/after/indent"
#ln -sf "$DOTFILES/nvim/after/indent" "$VIMCONFIG/after"
#
## snippets
#rm -rf "$VIMCONFIG/UltiSnips"
#ln -sf "$DOTFILES/nvim/UltiSnips" "$VIMCONFIG"
#
## :help ftplugin
#ln -sf "$DOTFILES/nvim/ftplugin" "$VIMCONFIG"
#
## :help ftdetect
#ln -sf "$DOTFILES/nvim/ftdetect" "$VIMCONFIG"
#
## :help autoload
#ln -sf "$DOTFILES/nvim/autoload" "$VIMCONFIG"
#
## thesaurus
#rm -rf "$VIMCONFIG/thesaurus"
#ln -sf "$DOTFILES/nvim/thesaurus" "$VIMCONFIG"
#
## spell files
#ln -sf "$DOTFILES/nvim/spell" "$VIMCONFIG"

## queries
#rm -rf "$VIMCONFIG/queries"
#ln -sf "$DOTFILES/nvim/queries" "$VIMCONFIG/queries"
