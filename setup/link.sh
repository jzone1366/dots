#!/usr/bin/bash

# Symlink all the files in the link directory to the HOME directory and append .
function do_link() {
  local base dest
  local files=($DOTFILES/link/*)

  if (( ${#files[@]} == 0 )); then 
    echo -e "${RED}No Files Found.${NC}"
    return
  fi

  # Iterate over these files
  for file in "${files[@]}"; do
    base="$(basename $file)"
    dest="$HOME/.$base"

    if [ -d ${dest} ]; then
      backup_dir ${dest}
    fi

    echo -e "${PURPLE}Linking ${base} to ${dest}${NC}"
    ln -sf ${file} ${dest} 
  done

}

do_link
