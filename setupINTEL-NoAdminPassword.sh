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
        intellij-idea
        pycharm
        slack
        #google-chrome
        pgadmin4
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        intellij-idea
        pycharm
        slack
        #google-chrome
        pgadmin4
    )
    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup
  
    giveInstructionsForNonAdminSetup
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
        pycharm
        azure-data-studio
        microsoft-azure-storage-explorer
        rstudio
    #    visual-studio
        visual-studio-code
        slack
        #google-chrome
        pgadmin4
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        pycharm
        azure-data-studio
        microsoft-azure-storage-explorer
        rstudio
    #    visual-studio
        visual-studio-code
        slack
        #google-chrome
        pgadmin4
    )

    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

    giveInstructionsForNonAdminSetup
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
            intellij-idea
            pycharm
            azure-data-studio
            microsoft-azure-storage-explorer
            rstudio
            visual-studio
            visual-studio-code
            slack
            #google-chrome
            pgadmin4
        )
        # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
        CASKS_UNINSTALL=(
            intellij-idea
            pycharm
            azure-data-studio
            microsoft-azure-storage-explorer
            rstudio
            visual-studio
            visual-studio-code
            slack
            #google-chrome
            pgadmin4
        )

        echo "$MODE-ing cask apps..."
        doBrewCaskInstallOrUninstall;
        echo "Cleaning up..."
        brew cleanup
        
        giveInstructionsForNonAdminSetup
    
}

giveInstructionsForNonAdminSetup(){
      if [ "$MODE" = "install" ]
      then
        echo "The packages were installed. However, for a non admin Macbook without admin password, certain applications are not installed."        
        echo "These packages are to be installed form the Moj SelfService App store, and these apps are ones as follows.."
        echo "Install Docker from the MojSelfService App Store"
        echo "Install VirtualBox from the MojSelfService App Store"
        echo "Install SDKMAN from the sdkman website. However, note that you will have to do some steps with setting the sdkman in your path"
        echo "Install R and Parallels only if you need these, from the MoJSelfService App Store"
      fi
}


doBrewPackageInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # PACKAGES           : The list of packages that are going to be installed (if this is an install)
    # PACKAGES_UNINSTALL : The list of packages that are going to be installed (if this is an install)
    case "$MODE" in
        'install')
                for i in "${PACKAGES[@]}"; do
                    echo "Installing package $i...."
                    brew install $i
                done
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
                for i in "${CASKS[@]}"; do
                    echo "Installing cask $i....."
                    brew install --cask --force $i --appdir=~/Applications
                done
                ;;
        'uninstall')
                for i in "${CASKS_UNINSTALL[@]}"; do
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
determine_mac_arch(){
        ARCH="$(uname -p)"
        echo "This Macbook has Architecture type = $ARCH"
        # This script is to setup Intel Macbooks Check if the ARCH is correct. If not, then exit the script and ask the user to run the correct script.
        if [ "$ARCH" = "arm" ]
        then
           echo "WARNING!!!!! This script is only for Macbooks with the Intel chip."
           echo "You are NOT using the correct setup script for this type of Macbook. This script is only for Macbooks with the Intel chip."
           echo "We will exit the script now. Please try and run the correct setupARM.sh script for your chipset"
           echo "EXITING NOW.."
           exit 1
        fi
        echo "You are using the correct setup script for this type of Macbook. setupINTEL.sh" 
}

 # Install homebrew if not already installed
install_homebrew(){
        if test ! $(which brew); then
           
          # now test again for brew
          if test ! $(which brew); then
            echo "Installing homebrew...NOTE : On INTEL boxes this is installed in /usr/bin"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
          fi

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
# Version 0.5 - Rajiv Kapoor (added uninstall functionality)
# Version 0.6 - Rajiv Kapoor (minor changes. removed google-chrome and also allow it to work with M2)
# Version 0.7 - Rajiv Kapoor (minor changes. More specific changes to detect between M2 and Intel especially re: parallels installation)
# Version 0.8 - Rajiv Kapoor (Made this file now and going forward just for installation on Intel based chipsets)
# Version 0.9 - Rajiv Kapoor (This file is for non-admin Macbooks on Intel based chipsets. It no longer installs docker,virtualbox,adoptopenjdk,R and parallels)
# Instead of Adopopenjdk, the user is advised to install sdkman, which will allow him/her to install multiple Java versions
# The other BIG change is that for non-admin Macbooks, ALL Cask installs will install the applications into ~/Applications directory rather than /Applications
# (This is because /Applications directory is protected and typically needs an Admin password. Hence we use --appdir flag to install to ~/Applications instead)


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
determine_mac_arch

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

