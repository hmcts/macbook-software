#!/bin/bash

#software for DTS Developers
developers(){
# Collection of packages to install
PACKAGES=(
    git
    node@14
    postgresql@12
    libpq
    python3
    azure-cli
    yq
)
echo "Installing packages..."
brew install ${PACKAGES[@]}
echo "Cleaning up..."
brew cleanup
#now install casks
CASKS=(
    docker
    adoptopenjdk
    intellij-idea
    pycharm
    slack
    google-chrome
    pgadmin4
    parallels
)
echo "Installing cask apps..."
brew install --cask --force ${CASKS[@]}
echo "Cleaning up..."
brew cleanup
}

#software for A&P Data Engineers
dataengineers(){
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
#now install casks
CASKS=(
    docker
    pycharm
    azure-data-studio
    microsoft-azure-storage-explorer
    R
    rstudio
#    visual-studio
    visual-studio-code
#    virtualbox
    slack
    google-chrome
    pgadmin4
    parallels
)
echo "Installing cask apps..."
brew install --cask --force ${CASKS[@]}
echo "Cleaning up..."
brew cleanup
}

#all software
allsoftware(){
# Collection of packages to install
PACKAGES=(
    git
    npm
    postgresql
    libpq
    python3
    azure-cli
    yq
)
echo "Installing packages..."
brew install ${PACKAGES[@]}
echo "Cleaning up..."
brew cleanup
#now install casks
CASKS=(
    adoptopenjdk
    intellij-idea
    docker
    pycharm
    azure-data-studio
    microsoft-azure-storage-explorer
    R
    rstudio
    visual-studio
    visual-studio-code
#    virtualbox
    slack
    google-chrome
    pgadmin4
    parallels
)
echo "Installing cask apps..."
brew install --cask --force ${CASKS[@]}
echo "Cleaning up..."
brew cleanup
}

 # Install homebrew if not already installed
install_homebrew(){
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
# Update homebrew
brew update
}

clear
# Bootstrap script for setting up a new OSX machine
# for Digital Delivery devs and QAs.

# Version 0.1 - Thomas Geraghty
# Version 0.2 - Thomas Geraghty
# Version 0.3 - Sandy Gudgeon
# Version 0.4 - Thomas Geraghty

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
echo
echo "DTS Macbook Development Tools Installer V0.3"
echo ""
echo "Any problems email :"
echo "Thomas Geraghty - thomas.geraghty@justice.gov.uk for DTS Developer/QA queries"
echo "Alexander Gudgeon - alexander.gudgeon@justice.gov.uk for A&P Data Engineering queries"
echo ""
ECHO "Pease enter your choice: "
options=("DTS Developer Tools" "A&P Data Engineer Tools" "All Tools" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "DTS Developer Tools")
            echo "you chose to install tools for $opt - $REPLY"
            install_homebrew
            developers
            break
            ;;
        "A&P Data Engineer Tools")
            echo "you chose to install tools for $opt - $REPLY"
            install_homebrew
            dataengineers
            break
            ;;
        "All Tools")
            echo "you chose choice to install $opt - $REPLY"
            install_homebrew
            allsoftware
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
