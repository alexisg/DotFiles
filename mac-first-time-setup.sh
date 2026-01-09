#!/usr/bin/env bash

# Make sure to chmod this script 
# chmod 755 mac-first-time-setup.sh

# Let's check to see if Xcode, Brew, and OhMyZDH, App Store CLI are already installed and if not

# XCode CLI
# ---------

if test ! $(which xcode-select); then
  echo -e "Installing xcode-stuff CLI...\n"
  xcode-select --install
else 
  echo -e "Xcode CLI already installed...\n"
fi

# Homebrew
# ---------

if test ! $(which brew); then
  echo -e "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else 
  echo -e "Brew already installed...\n"
fi

# Oh MY ZSH
# ---------

if ! [ -d "$HOME/.oh-my-zsh" ]; then
  echo -e "Installing OhMyZSH...\n"
  curl -L http://install.ohmyz.sh | sh
else 
  echo -e "OhMyZSH already installed...\n"
fi

# Mac App Store CLI
# -----------------
# Grab the MAS id by simply using the id found in the share link of an app

if test ! $(which mas); then
  echo -e "Installing mas...\n"
  brew install mas
else 
  echo -e "MAS already installed...\n"
fi

# Once dropbox is installed create a symlink to zsh file. 
# Keeping this here as reference as you can not set this up on first launch
# You can keep this on Git as well but just seems to be much easier keeping on dropbox and backing up on github.
# ln -s ~/Dropbox/Documents/DotFiles/zshrc ~/.zshrc


# NMV Manager

if ! [ -d "$HOME/.nvm" ]; then
  echo -e "Installing NVM...\n"
  brew install nvm
  nvm install node
else 
  echo -e "NVM already installed...\n"
fi

# Yarn
brew install yarn

# Git
brew install git

git config --global user.name "Alexis Gallisá"
git config --global user.email alexis@alexisgallisa.com

# ------------------------------ #
# Install apps using brew or mas
# ------------------------------ #

brew install --cask 1password
brew install --cask alfred
brew install --cask cleanshot
brew install --cask dropbox
brew install --cask figma
brew install --cask github
brew install --cask google-chrome
brew install --cask handbrake-app
brew install --cask ImageOptim
brew install --cask warp
brew install --cask jordanbaird-ice
brew install --cask omnidisksweeper
brew install --cask rocket
brew install --cask sim-daltonism
brew install --cask swish
brew install --cask transmit
brew install --cask cursor
brew install --cask stats
brew install --cask moom
brew install --cask reminders-menubar
brew install --cask grammarly-desktop
brew install --cask slack
brew install --cask wifi-explorer
brew install --cask coteditor
brew install --cask fantastical


# color-slurp
# mas install 1287239339

# Photo Mill
mas install 778590574

# Snippets Lab
mas install 1006087419

# Name Mangler
mas install 603637384

#Speedtest
mas install 1153157709

#SoundPaste
mas install 6471012328 

#Photomator – Photo Editor
mas install 1444636541

#Cascadea
mas install 1432182561

#Gifski - Convert videos to GIFs
mas install 1351639930

#Hand Mirror
mas install 1502839586

#TestFlight
mas install 899247664

#Kaleidoscope
mas install 587512244