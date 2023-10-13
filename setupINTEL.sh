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
        #google-chrome
        pgadmin4
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        docker
        adoptopenjdk
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

    doParallelsSteps

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
        #google-chrome
        pgadmin4
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
        #google-chrome
        pgadmin4
    )

    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

    doParallelsSteps
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
            #google-chrome
            pgadmin4
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
            #google-chrome
            pgadmin4
        )

        echo "$MODE-ing cask apps..."
        doBrewCaskInstallOrUninstall;
        echo "Cleaning up..."
        brew cleanup
    
        doParallelsSteps
}

doParallelsSteps(){
      #if the mode is to uninstall, ensure that the uninstall of parallels is done, as a special case.
      if [ "$MODE" = "uninstall" ]
      then
          parallels_uninstall
      else
          parallels_install
      fi
}

#parallels install special case
parallels_install(){

        echo "Installing parallels now...."        
        brew install --cask --force parallels
        echo "Cleaning up..."
        brew cleanup
}

#parallels uninstall special case
parallels_uninstall(){

        echo "Uninstalling parallels now...."        
        brew uninstall --cask --force parallels
        echo "Cleaning up..."
        brew cleanup


cat << "EOF2"
The uninstall has now finished.....

**** Steps to complete Post uninstall of parallels ****
Please read the below...
The uninstall of parallels should have completed. However, due to an anomoly with the way that parallels installs
, the uninstall may or may not have reported an error. Please follow the instructions below carefully..

you may have seen something like this at the end of the parallels uninstall...
--------------------------------------------------------------------------
Cleaning up...
Error: Permission denied @ apply2files - /usr/local/share/man/man8/prl_convert.8

Steps to carry out to resolve any errors...
------------------------------------------
1. Try and check the health of brew. Try to install something that you havent already got, and see if brew complains. eg. try and install jq.
   >brew install jq (if you already have jq installed, please do a brew uninstall jq followed by the install)
2. If you dont see any errors, then you can exit now, as parallels would have uninstalled without causing any problems.
3. However, if you did see an error, then brew tells you how to rectify this.
4. Follow the instructions given by brew, if it is only changing the owner of the /usr/local/share/man/man8 directory, as this is fairly harmless thing to do.
5. If it is merely changing the owner, please indeed follow the suggested solution by brew.
6. If it is more complex, then please seek help from the authors of this script.
EOF2
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
                    brew install --cask --force $i
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

