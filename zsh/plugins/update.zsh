update() {
  echo 'start updating ...'

  echo 'updating homebrew'
  brew update
  brew upgrade
  brew reinstall neovim
  brew cleanup

  #echo 'checking Apple Updates'
  #/usr/sbin/softwareupdate -ia
}

