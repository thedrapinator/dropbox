#!/bin/bash

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as root user :)"
else
        echo "Please run with sudo!"
        exit 1
fi

cd ~
echo "UPDATING…"
sudo apt update && sudo apt upgrade -y

echo "INSTALLING OPENVPN…"
wget https://git.io/vpn -O openvpn-install.sh
sudo chmod +x openvpn-install.sh
sudo ./openvpn-install.sh

sudo systemctl enable openvpn

echo "INSTALL COMPLETE! 
echo "To add users or dropboxes please run sudo ./openvpn-install.sh and name the dropboxes dropbox1, dropbox2, etc…"
