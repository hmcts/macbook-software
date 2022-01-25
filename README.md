# macbook-software
 
### A bash script to install tools used by DTS Developers & A&P Data Engineers
 
Click the Launchpad (Rocket icon) and search for Terminal. Open a terminal – The Mac terminal seems to be almost identical to a Linux Bash Shell. Like using WSL on Windows.
 
Enter the following into the terminal:
 
- Create folder called Projects % `mkdir Projects`
- Navigate to the new folder % `cd Projects`
- Install Git % `git init`
- Clone the repo to download the files % `git clone https://github.com/hmcts/macbook-software`
- Navigate to the macbook-software folder % `cd macbook-software`
- Make it executable % `chmod +x setup.sh`
- Run the script % `./setup.sh`
 
As the script runs it will prompt several times for admin password to proceed with an install. The admin password is the one you use to login to the Macbook, not your AppleId password.

You can also use the simple following one-liner in the terminal to run the script without needing to download, set permissions etc.
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/hmcts/macbook-software/master/setup.sh)"`
 
### The software to be installed is:
 
**For A&P users:**
 
- git
- npm
- postgresql
- python3
- azure-cli
- docker
- pycharm
- azure-data-studio
- microsoft-azure-storage-explorer
- R
- rstudio
- visual-studio
- visual-studio-code
- slack
- google-chrome
- pgadmin4
 
**For DTS Developers:**
 
- git
- npm
- postgresql
- python3
- azure-cli
- yq
- docker
- adoptopenjdk
- intellij-idea
- pycharm
- slack
- google-chrome
- pgadmin4
