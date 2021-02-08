#!/usr/bin/env bash
# Bootstrap script for setting up a new OSX machine
# for Digital Delivery devs and QAs.


# Version 0.2 - Made by Thomas Geraghty

cat << "EOF"
 _   _ ___  ________ _____ _____   _____________
| | | ||  \/  /  __ \_   _/  ___|  |   _.+._   |
| |_| || .  . | /  \/ | | \ `--.   | (^\/^\/^) |
|  _  || |\/| | |     | |  `--. \  |  \@*@*@/  |
| | | || |  | | \__/\ | | /\__/ /  |  {_____}  |
\_| |_/\_|  |_/\____/ \_/ \____/   |___________|
 ____  _____ _____ 
|    \|_   _|   __|     Welcome to Digital Delivery         
|  |  | | | |__   |     Inspiring change and lookin' cool   
|____/  |_| |_____|     whilst we do it!                    
EOF

echo ''
echo "Beginning bootstrap installation script!"
sleep 1s

# Install homebrew if not already installed
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update homebrew
brew update

echo "Installing homebrew-cask..."
brew install caskroom/cask/brew-cask

# Collection of packages to install
PACKAGES=(
    git
    npm
    postgresql
    python3
    azure-cli
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

# Could install apps from Self Service from here instead?
# If one of these is already installed, the install op will fail and miss any other packages. 
CASKS=(
   
    adoptopenjdk
    intellij-idea
    pycharm
    azure-data-studio
    datagrip
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Cleaning up..."
brew cleanup

echo "Bootstrapping complete"
