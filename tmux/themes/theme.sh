#!/bin/bash

get_system_mode() {
	# Check status of dark mode (ignore errors, i.e., when light mode is enabled).
	local status="$(defaults read -g AppleInterfaceStyle 2>/dev/null)"
	# Return system mode.
	if [[ $status == "Dark" ]]; then
		echo "dark"
	else
		echo "light"
	fi
}

get_theme() {
  echo "WHAT"
  local mode=$(get_system_mode)
  echo $mode
  if [[ $mode == "dark" ]]; then
    echo "TEST"
    source-file "$DOTFILES/tmux/themes/catppuccin-mocha.tmux"
  else
    echo "TEST"
    source-file "$DOTFILES/tmux/themes/catppuccin-latte.tmux"
  fi
}

get_theme()
