# macbook-software
 
### bash scripts to install tools used by DTS Developers & DAI Data Engineers

Choose the correct script for your particular Macbook. It may have Intel chipsets or Arm chipsets.

- setupINTEL.sh (use this script if you are running an Intel based Mac)
- setupARM.sh   (use this script if you are running an  ARM  based Mac)
- setupINTELforNonAdminMacs.sh (use this script if you are running an Intel based Mac which does NOT have admin permissions)
- setupARMforNonAdminMacs.sh   (use this script if you are running an  ARM  based Mac which does NOT have admin permissions)
- setDockerHostForNonAdminMacs.sh (use this script if you are running any Mac which does NOT have admin permissions AFTER you have installed DockerDesktop in the way it should be installed for non admin Macs as per Confluence page)

Note: The scripts for the Non Admin Macs do exactly the same installs except that Casks are installed into ~/Applications folder rather than /Applications folder

To run the script (for full Admin macbooks), use the simple following one-liner in the terminal

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/hmcts/macbook-software/master/setup<INTEL|ARM>.sh)"`
 
To run the script (for NonAdmin macbooks), use the simple following one-liner in the terminal

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/hmcts/macbook-software/master/setup<INTEL|ARM>forNonAdminMacs.sh)"`

Alternatively, enter the following into the terminal (requires Git to be installed):
 
- Create folder called Projects `mkdir Projects`
- Navigate to the new folder `cd Projects`
- Install Git `git init`
  - Note: If prompted to install xCode CLI tools, allow the install to proceed as it will add git and a few other CLI tools to your system.
- Clone the repo to download the files % `git clone https://github.com/hmcts/macbook-software`
- Navigate to the macbook-software folder % `cd macbook-software`
- Make it executable % `chmod +x setup*.sh`
- Run the relevant setup.sh script for your platform and whether you have Admin or not
 
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
- docker (only for full admin macs. non admin users should get from MoJ Self Service store)
- pycharm
- azure-data-studio
- microsoft-azure-storage-explorer
- R (only for full admin macs. non admin users should get from MoJ Self Service store)
- rstudio
- visual-studio-code
-#visual-studio (no longer installed - user is advised to use the free version which is visual-studio-code)
- slack
- pgadmin4
- parallels (only for INTEL based Macbooks)
-#google-chrome(no longer installed - user is advised to obtain from MoJ SelfService App)
-#virtualbox(no longer installed - user is advised to obtain from MoJ SelfService App)

**For DAI users:**

- git
- npm
- postgresql
- python3
- azure-cli
- docker (only for full admin macs. non admin users should get from MoJ Self Service store)
- pycharm
- azure-data-studio
- microsoft-azure-storage-explorer
- R (only for full admin macs. non admin users should get from MoJ Self Service store)
- rstudio
- visual-studio-code
-#visual-studio (no longer installed - user is advised to use the free version which is visual-studio-code)
- slack
- pgadmin4
- parallels (only for INTEL based Macbooks)
-#visual-studio (no longer installed - user is advised to use the free version which is visual-studio-code)

**For DTS Developers:**

- git
- node@14
- postgresql@12
- libpq
- python3
- azure-cli
- yq
- docker (only for full admin macs. non admin users should get from MoJ Self Service store)
- adoptopenjdk
- intellij-idea
- pycharm
- slack
- pgadmin4
- parallels (only for INTEL based Macbooks)p
-#google-chrome(no longer installed - user is advised to obtain from MoJ SelfService App)

### The setDockerHostForNonAdminMacs.sh does:

- sets PATH to find a local docker executable in home-dir/.docker/bin
- sets DOCKER_HOST variable to find a local docker.sock file
