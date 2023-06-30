# macbook-software
 
### A bash script to install tools used by DTS Developers & A&P Data Engineers
 
To run the script, use the simple following one-liner in the terminal

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/hmcts/macbook-software/master/setup.sh)"`
 
Alternatively, enter the following into the terminal (requires Git to be installed):
 
- Create folder called Projects `mkdir Projects`
- Navigate to the new folder `cd Projects`
- Install Git `git init`
  - Note: If prompted to install xCode CLI tools, allow the install to proceed as it will add git and a few other CLI tools to your system.
- Clone the repo to download the files % `git clone https://github.com/hmcts/macbook-software`
- Navigate to the macbook-software folder % `cd macbook-software`
- Make it executable % `chmod +x setup.sh`
- Run the script % `./setup.sh`
 
As the script runs it will prompt several times for admin password to proceed with an install. The admin password is the one you use to login to the Macbook, not your Apple ID password.


 
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
- pgadmin4
