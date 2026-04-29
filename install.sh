#!/usr/bin/env bash

# Copy the default config file if not present already

############
# includes #
############

#[ ! -f install_config ] && cp install_config.dist install_config

#source ./install_config
source ./colors.sh
source ./install_functions.sh
source ./zsh/zshenv

################
# presentation #
################

echo -e "
${yellow}
          _ ._  _ , _ ._
        (_ ' ( \`  )_  .__)
      ( (  (    )   \`)  ) _)
     (__ (_   (_ . _) _) ,__)
           ~~\ ' . /~~
         ,::: ;   ; :::,
        ':::::::::::::::'
 ____________/_ __ \____________
|                               |
| Welcome to zonejm's  dotfiles |
|_______________________________|
"

echo -e "${yellow}!!! ${red}WARNING${yellow} !!!"
echo -e "${light_red}This script will delete all your configuration files!"
echo -e "${light_red}Use it at your own risks."

if [ $# -ne 1 ] || [ "$1" != "-y" ];
    then
        echo -e "${yellow}Press a key to continue...\n"
        read key;
fi

###########
# INSTALL #
###########

# Detect OS
case "$(uname -s)" in
    Darwin) OS="mac" ;;
    Linux)  OS="linux" ;;
    *)      OS="unknown" ;;
esac

# Zsh — always
. "$DOTFILES/install/install-zsh.sh"

# Cross-platform tools
dot_is_installed bat     && dot_install bat
dot_is_installed nvim    && dot_install nvim
dot_is_installed tmux    && dot_install tmux
dot_is_installed zellij  && dot_install zellij
dot_is_installed wezterm && dot_install wezterm
dot_is_installed git     && dot_install git
dot_is_installed php     && dot_install php

# macOS-only tools
if [ "$OS" = "mac" ]; then
    dot_is_installed zathura    && dot_install zathura
    dot_is_installed figma      && dot_install figma
    dot_is_installed sketchybar && dot_install sketchybar
fi
