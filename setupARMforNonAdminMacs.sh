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
        #docker Needs password so better installed via MoJ Self service store
        adoptopenjdk
        intellij-idea
        pycharm
        slack
        #google-chrome
        pgadmin4
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        #docker Needs password so better installed via MoJ Self service store
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
        #docker Needs password so better installed via MoJ Self service store
        pycharm
        azure-data-studio
        microsoft-azure-storage-explorer
        #R Needs password so better installed via MoJ Self service store
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
        #docker Needs password so better installed via MoJ Self service store
        pycharm
        azure-data-studio
        microsoft-azure-storage-explorer
        #R Needs password so better installed via MoJ Self service store
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
            #docker Needs password so better installed via MoJ Self service store
            pycharm
            azure-data-studio
            microsoft-azure-storage-explorer
            #R Needs password so better installed via MoJ Self service store
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
            #docker Needs password so better installed via MoJ Self service store
            pycharm
            azure-data-studio
            microsoft-azure-storage-explorer
            #R Needs password so better installed via MoJ Self service store
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
    #show a note that the parallels is not installed for ARM chipsets using brew
    echo "The uninstall/install of all of the software has finished."
    echo "..However, please note. As this is the install script for the ARM(M1/M2) machines, we could not and did not install parallels using brew"
    echo "parallels software allows you to have separate boot partitions on your Macbook and is not often required"
    echo "However, if you wish to install this on those box types, please install parallels another way"
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
                    echo "Installing cask $i....INTO your home_directory/Applications folder"
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

 # determine Macbook is eitrher INTEL based or ARM (M1/M2) based
determine_mac_arch(){
        ARCH="$(uname -p)"
        echo "This Macbook has Architecture type = $ARCH"
        # This script is to setup ARM Macbooks Check if the ARCH is correct. If not, then exit the script and ask the user to run the correct script.
        if [ "$ARCH" = "arm" ]
        then
           echo "You are using the correct setup script for this type of Macbook. setupARMforNonAdminMacs.sh" 
        else
           echo "WARNING!!!!! This script is only for Macbooks with the ARM(M1/M2) chipsets."
           echo "You are NOT using the correct setup script for this type of Macbook. This script is only for Macbooks with the ARM(M1/M2) chipisets"
           echo "We will exit the script now. Please try and run the correct setupINTELforNonAdminMacs.sh script for your chipset"
           echo "EXITING NOW.."
           exit 1
        fi
}

 # Install homebrew if not already installed
install_homebrew(){
        if test ! $(which brew); then
           
          if [ "$ARCH" = "arm" ]
          then
            # On M1/M2 boxes, try source'ing the .zprofile, as brew if it had been installed partially from before, it should have left a command there.
            source ~/.zprofile
          fi

          # now test again for brew
          if test ! $(which brew); then
            echo "Installing homebrew...NOTE : On M2 boxes this is installed in /opt/homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        
            if [ "$ARCH" = "arm" ]
            then
              echo "We have detected that this Macbook is an ARM(M1/M2) Silicon Macbook"
              echo "On these box types, brew is not automatically added to one's path"
              echo "Therefore, we urge you to add this eval line (only the first line) to your .zhrc or .bashrc files"
              set -x
              eval $(/opt/homebrew/bin/brew shellenv)
              set +x
            fi
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
# Version 0.8 - Rajiv Kapoor (Made this file now and going forward just for installation on ARM(M1/M2) based chipsets)
# Version 0.9 - Rajiv Kapoor (Made this specific file now for Non Admin Macbooks.It uses the --appdir flag when installing Casks 
# Version 1.0 - Rajiv Kapoor (No longer installs Docker and R, as these should be installed via SelfServiceStore or another way 

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
echo "Rajiv Kapoor - rajiv.kapoor@justice.gov.uk for general queries on this script"
echo ""
determine_mac_arch

ECHO "Pease enter your choice: "
options=("Install DTS Developer Tools" "Install A&P Data Engineer Tools" "Install All Tools" "*UNINSTALL DTS Developer Tools" "*UNINSTALL A&P Data Engineer Tools" "*UNINSTALL All Tools" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install DTS Developer Tools")
            echo "you chose to install tools for $opt - $REPLa"
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

