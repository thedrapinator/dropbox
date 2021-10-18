#!/bin/bash

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as user with sudo privs :)"
else
        echo "Please run with standard (NON ROOT) user and sudo!"
        exit 1
fi

echo "###### CLONING LATEST FILES ######"
cd /opt/
sudo git clone https://github.com/sirchsec/dropbox.git
cd /opt/dropbox
sudo chmod +x /opt/dropbox/*

echo "###### RUNNING DROPBOX SETUP SCRIPT ######"
sudo /opt/dropbox/dropbox_setup.sh

echo "###### RUNNING DROPBOX TOOLS SCRIPT ######"
sudo /opt/dropbox/dropbox_tools.sh

echo "###### RUNNING WIFI TOOLS SCRIPT ######"
sudo /opt/dropbox/wifi_tools.sh

echo "###### CHANGING TO OPENVPN MASTER FILE ######"   #COMTAINS REBOOT PROMPT
sudo /opt/dropbox/openvpn_change.sh
