#!/bin/bash

usage="$(basename "$0") [-l] [-h] [-p] [-c] -- script to install dotfiles

where:
  -l  just symlink all folders in /link
  -h  show this help text
  -p  postinstall will run after everything else is done
  -c  config will symlink anything inside of config into the .config directory"

#arg options
DO_LINK=0;  # Run do_link
DO_POST=0;  # Run do_init
DO_CONFIG=0;  # Run do_config

#parse the options
while getopts lhpc OPT ; do
  case $OPT in
    l) DO_LINK=1;;
    p) DO_POST=1;;
    c) DO_CONFIG=1;;
    h)
      echo -e "${usage}"
      exit 1
      ;;
    \?) printf "Illegal options: -%s\n" "$OPTARG" >&2
      echo -e "$usage" >&2
      exit 1
      ;;
  esac
done
# Helper Functions
function backup_dir() {
  local dest=$HOME/backups/$(date "+%Y_%m_%d-%H_%M_%S")
  local base="$(basename $file)"
  echo -e "${CYAN}backing up $1 to ${dest}${NC}"

  mkdir -p ${dest}
  mv $1 ${dest}/${base}
}

RED='\033[0;31m';
GREEN='\033[0;32m';
ORANGE='\033[0;33m';
BLUE='\033[0;34m';
PURPLE='\033[0;35m';
CYAN='\033[0;36m';
YELLOW='\033[1;33m';
WHITE='\033[1;37m';
NC='\033[0m';

export DOTFILES=$HOME/.dotfiles

echo -e "${CYAN}A whole new world..... (Installing DotFiles)${NC}"

if [ ${DO_LINK} -eq 1 ]; then
  source ${DOTFILES}/setup/link.sh
fi

if [ ${DO_CONFIG} -eq 1 ]; then
  source ${DOTFILES}/setup/config.sh
fi

if [ ${DO_POST} -eq 1 ]; then
  source ${DOTFILES}/setup/postinstall.sh
fi

echo -e "${GREEN}DONE! Reload this thing to get it to work.${NC}"
