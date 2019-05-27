# Dotfiles
My dotfiles to start version controlling my setups for vim and other programs.
Inspiration for the structure came from https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles

## Installation
You need to clone this repository by running
`git clone git@github.com:jzone1366/dotfiles.git`

Once it's cloned then you can run `setup.sh` to get the options for installation.

## Configuration
Inside the `setup/` directory is all the scripts that run.
1. `link.sh` will symlink everything that is inside the `link/` directory to your home directory and prepend a `.`
1. `postinstall.sh` will run commands that are inside the `postinstall/` directory after all the other commands have run. (this installs a package loader for vim after the directories have been linked and initialized)

## Disclaimer
This is a work in progress. This is also set to defaults that I use and may not work correctly on your machine. 
I currently use these settings on my Macbook at work and on my Linux Mint Machine at home.


## TODO:
* Add Linux script to install dependencies for Linux Mint.
* Add MacOSX script to install dependencies for Mac.
* Change command line flags to Multi Select Menu for easier option selection.
