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
    # Same packages, but a Seperate list for uninstall packages, as the order may need to be different
    PACKAGES_UNINSTALL=(
        azure-cli
        git
        node@14
        postgresql@12
        libpq
        python3        
        yq
    )
    echo "$MODE-ing packages..."
    doBrewPackageInstallOrUninstall;
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
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        docker
        adoptopenjdk
        intellij-idea
        pycharm
        slack
        google-chrome
        pgadmin4
        parallels
    )
    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
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
    # Same packages, but a Seperate list for uninstall packages, as the order may need to be different
    PACKAGES_UNINSTALL=(
        azure-cli
        git
        npm
        postgresql
        python3
    )

    echo "$MODE-ing packages..."
    doBrewPackageInstallOrUninstall;
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
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
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

    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
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
        # Same packages, but a Seperate list for uninstall packages, as the order may need to be different
        PACKAGES_UNINSTALL=(
            azure-cli
            git
            npm
            postgresql
            libpq
            python3
            yq
        )

        echo "$MODE-ing packages..."
        doBrewPackageInstallOrUninstall;
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
        # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
        CASKS_UNINSTALL=(
            adoptopenjdk #password may be necessary
            intellij-idea
            docker #password alwyas seems to be required
            pycharm
            azure-data-studio
            microsoft-azure-storage-explorer
            R #password may be necessary
            rstudio
            visual-studio
            visual-studio-code
        #    virtualbox
            slack
            google-chrome
            pgadmin4
            parallels
        )

        echo "$MODE-ing cask apps..."
        doBrewCaskInstallOrUninstall;
        echo "Cleaning up..."
        brew cleanup
}

doBrewPackageInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # PACKAGES           : The list of packages that are going to be installed (if this is an install)
    # PACKAGES_UNINSTALL : The list of packages that are going to be installed (if this is an install)
    case "$MODE" in
        'install')
                brew install ${PACKAGES[@]}
                ;;
        'uninstall')
                for i in "${PACKAGES_UNINSTALL[@]}"; do
                    echo "uninstalling package $i...."
                    brew uninstall $i
                done
                ;;
            *)
                echo "unexpected error. Exiting...."
                return 1
    esac
}

doBrewCaskInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # CASKS              : The list of casks that are going to be installed (if this is an install)
    # CASKS_UNINSTALL    : The list of casks that are going to be installed (if this is an install)
    case "$MODE" in
        'install')
                brew install --cask --force ${CASKS[@]}
                ;;
        'uninstall')
                for i in "${CASKS[@]}"; do
                    echo "Uninstalling cask $i....."
                    brew uninstall --cask --force $i
                done
                ;;
            *)
                echo "unexpected error. Exiting...."
                return 1
    esac
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
options=("Install DTS Developer Tools" "Install A&P Data Engineer Tools" "Install All Tools" "*UNINSTALL DTS Developer Tools" "*UNINSTALL A&P Data Engineer Tools" "*UNINSTALL All Tools" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install DTS Developer Tools")
            echo "you chose to install tools for $opt - $REPLY"
            MODE=install
            install_homebrew
            developers
            break
            ;;
        "Install A&P Data Engineer Tools")
            echo "you chose to install tools for $opt - $REPLY"
            MODE=install
            install_homebrew
            dataengineers
            break
            ;;
        "Install All Tools")
            echo "you chose choice to install $opt - $REPLY"
            MODE=install
            install_homebrew
            allsoftware
            break
            ;;
        "*UNINSTALL DTS Developer Tools")
            echo "you chose to Uninstall tools for $opt - $REPLY"
            MODE=uninstall
            #check that folks are sure whether they wish to uninstall....
            echo -n "Answer \"yes\" if you are sure you wish to uninstall..."
            read ANSWER
            if [ "$ANSWER" = "yes" ]
            then
                #even though we are uninstalling we still need to install brew
                install_homebrew
                developers
            else
                echo "Bailing out..."
            fi
            break
            ;;
        "*UNINSTALL A&P Data Engineer Tools")
            echo "you chose to Uninstall tools for $opt - $REPLY"
            MODE=uninstall
            #check that folks are sure whether they wish to uninstall....
            echo -n "Answer \"yes\" if you are sure you wish to uninstall..."
            read ANSWER
            if [ "$ANSWER" = "yes" ]
            then
                #even though we are uninstalling we still need to install brew
                install_homebrew
                dataengineers
            else
                echo "Bailing out..."
            fi
            break
            ;;
        "*UNINSTALL All Tools")
            echo "you chose choice to Uninstall $opt - $REPLY"
            MODE=uninstall
            #check that folks are sure whether they wish to uninstall....
            echo -n "Answer \"yes\" if you are sure you wish to uninstall..."
            read ANSWER
            if [ "$ANSWER" = "yes" ]
            then
                #even though we are uninstalling we still need to install brew
                install_homebrew
                allsoftware
            else
                echo "Bailing out..."
            fi
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

