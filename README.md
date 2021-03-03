# macbook-software
A bash script to install tools used by DTS Developers &amp; A&amp;P Data Engineers

Open a terminal – The Mac terminal seems to be almost identical to a Linux Bash Shell.  Like using WSL on Windows.

Create a folder for this, I created /Projects/macbook-software

In the folder ‘Git init’ then ‘Git pull https://github.com/hmcts/macbook-software’ – the files will be downloaded - you may have to login to Github first

This way the folder is a Git repository & VSCode will recognise it as such if you wanted to edit the bash file

In the folder ‘chmod +x setup.sh’ to make it executable

In the folder run the script with ‘./setup.sh’

As the script runs it will prompt several times for admin password to proceed with an install.  The admin password is the one you use to login to the Macbook, not your AppleId password.
