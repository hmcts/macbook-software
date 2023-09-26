# macbook-software
 
### bash scripts to install tools used by DTS Developers & A&P Data Engineers

Choose the correct script for your particular Macbook. It may have Intel chipsets or Arm chipsets.

- setupINTEL.sh (use this script if you are running an Intel based Mac)
- setupARM.sh   (use this script if you are running an  ARM  based Mac)

To run the script, use the simple following one-liner in the terminal

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/hmcts/macbook-software/master/setup<INTEL|ARM>.sh)"`
 
Alternatively, enter the following into the terminal (requires Git to be installed):
 
- Create folder called Projects `mkdir Projects`
- Navigate to the new folder `cd Projects`
- Install Git `git init`
  - Note: If prompted to install xCode CLI tools, allow the install to proceed as it will add git and a few other CLI tools to your system.
- Clone the repo to download the files % `git clone https://github.com/hmcts/macbook-software`
- Navigate to the macbook-software folder % `cd macbook-software`
- Make it executable % `chmod +x setup*.sh`
- Run the script % `./setup<INTEL|ARM>.sh`
 
As the script runs it will prompt several times for admin password to proceed with an install. The admin password is the one you use to login to the Macbook, not your Apple ID password.

Each script does slighly different steps in places, for either the INTEL or ARM(M1/M2) architecture.
 
### The software to be installed is:

**ALL Software:**

- git
- npm
- postgresql
- libpq
- python3
- azure-cli
- yq
- adoptopenjdk
- intellij-idea
- docker
- pycharm
- azure-data-studio
- microsoft-azure-storage-explorer
- R
- rstudio
- visual-studio
- visual-studio-code
#virtualbox
- slack
#google-chrome
- pgadmin4
- parallels (only for INTEL based Macbooks)


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
#- visual-studio
- visual-studio-code
- slack
- pgadmin4
- parallels (only for INTEL based Macbooks)
 
**For DTS Developers:**

- git
- node@14
- postgresql@12
- libpq
- python3
- azure-cli
- yq
- docker
- adoptopenjdk
- intellij-idea
- pycharm
- slack
#google-chrome
- pgadmin4
- parallels (only for INTEL based Macbooks)
