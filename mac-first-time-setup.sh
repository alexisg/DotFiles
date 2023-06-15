#!/usr/bin/env bash

# Make sure to chmod this script 
# chmod 755 mac-first-time-setup.sh

git config --global user.name "Alexis Gallisá"
git config --global user.email alexis@alexisgallisa.com

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
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  nvm install node
else 
  echo -e "NVM already installed...\n"
fi

# Yarn
# brew install yarn

# Git
brew install git

# ------------------------------ #
# Install apps using brew or mas
# ------------------------------ #

brew install 1password
brew install alfred
brew install cleanshot
brew install dropbox
brew install figma
brew install github
brew install google-chrome
brew install handbrake
brew install homebrew/cask/handbrake
brew install ImageOptim
brew install iterm2
brew install rocket
brew install sim-daltonism
brew install spotify
brew install swish
brew install transmit
brew install visual-studio-code
brew install vlc

# brew install fantastical
mas install 975937182

# brew  install slack
mas install 803453959

# brew  install wifi-explorer
mas install 494803304

# color-slurp
mas install 1287239339

# Photo Mill
mas install 778590574

# Moom
mas install 419330170

# Snippets Lab
mas install 1006087419

# Name Mangler
mas install 603637384

#Speedtest
mas install 1153157709