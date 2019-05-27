#!/usr/bin/env bash

function do_config() {
  local base dest
  local files=($DOTFILES/config/*)

  if (( ${#files[@]} == 0 )); then 
    echo -e "${RED}No Files Found.${NC}"
    return
  fi

  # Iterate over these files
  for file in "${files[@]}"; do
    base="$(basename $file)"
    dest="$HOME/.config"

    if [ -d ${dest}/${base} ]; then
      backup_dir ${dest}/${base}
    fi

    mkdir ${dest}
    echo -e "${PURPLE}Linking ${base} to ${dest}${NC}"
    ln -sf ${file} ${dest}/${base} 
  done
}

do_config
