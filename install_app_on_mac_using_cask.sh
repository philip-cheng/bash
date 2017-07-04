#! /bin/bash

############################################################
# Install apps using cask
############################################################
# Apple or BASH script to automatically install multiple apps
# https://apple.stackexchange.com/questions/145653/apple-or-bash-script-to-automatically-install-multiple-apps

app_name=google-chrome

# If brew is installed, then install cask
brew install caskroom/cask/brew-cask

# Now use cask to install application
brew cask install $app_name

# Search app via cask
# brew cask search $app_name
