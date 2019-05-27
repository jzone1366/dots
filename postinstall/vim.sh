## Initializes a package loader for vim (uses minpac)
## Can be modified to pull whichever package loader is preferred
function init_package_loader() {
  # Minpac (https://github.com/k-takata/minpac)
  local ghUrl=https://github.com/k-takata/minpac.git
  local dest=${HOME}/.vim/pack/minpac/opt/minpac

  echo -e "${CYAN}Cloning minpack into ${dest} ${NC}"
  if [ -d ${dest} ]; then
    rm -rf ${dest}
  fi

  git clone ${ghUrl} ${dest}
}

## Run all the functions that are defined here.
function init_vim() {
  init_package_loader
}

echo -e "${CYAN}Initializing VIM${NC}"
init_vim
