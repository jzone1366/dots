update() {
  echo 'start updating ...'

  if $IS_MAC; then
    echo 'updating homebrew'
    brew update
    brew upgrade
    brew reinstall neovim
    brew cleanup
  elif $IS_LINUX; then
    echo 'updating apt packages'
    sudo apt-get update && sudo apt-get upgrade -y
  fi
}
