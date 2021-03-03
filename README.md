# macbook-software
A bash script to install tools used by DTS Developers &amp; A&amp;P Data Engineers

Open a terminal – The Mac terminal seems to be almost identical to a Linux Bash Shell.  Like using WSL on Windows.

Create a folder for this, I created /Projects/macbook-software
Open terminal
% mkdir Projects/macbook-software
% cd Projects/macbook-software
% git init
% git clone https://github.com/hmcts/macbook-software
# to download the files
% chmod +x setup.sh 
# to make it executable
% ./setup.sh
# to run the script

As the script runs it will prompt several times for admin password to proceed with an install.  The admin password is the one you use to login to the Macbook, not your AppleId password.

The software to be installed is 

For A&P users
    git
    npm
    postgresql
    python3
    azure-cli
    docker
    pycharm
    azure-data-studio
    microsoft-azure-storage-explorer
    R
    rstudio
    visual-studio
    visual-studio-code
    slack
    google-chrome
    pgadmin4

For DTS Developers
    git
    npm
    postgresql
    python3
    azure-cli
    docker
    adoptopenjdk
    intellij-idea
    pycharm
    slack
    google-chrome
    pgadmin4
