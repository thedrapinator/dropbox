#!/bin/bash

#dropbox username
echo "Please enter dropbox username! (usually kali or pentest)"
read username
echo "USERNAME = $username"

echo "Set new sudo password for $username user before running this script!"
sleep 1

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as user with sudo privs :)"
else
        echo "Please run with standard (NON ROOT) user and sudo!"
        exit 1
fi

echo "Disabling Sleep"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo "Please enter the ovpn file name which will be copied from the /home/$username/ folder!"
read filename
sudo cp /home/$username/$filename /etc/openvpn/openvpn.conf
#sudo rm /home/$username/$filename
sudo systemctl enable openvpn
echo "Copied and enabled dropbox openvpn file!"

echo "Please enter new hostname (companyname):"
read hostname
sudo hostnamectl set-hostname $hostname
echo "Hostname set to $hostname"

echo "UPDATING"
sudo apt update && sudo apt upgrade -y

echo "Installing and enabling RDP"
sudo apt install xrdp -y
service xrdp start
service xrdp-sesman start
update-rc.d xrdp enable

echo "Enabling SSH"
sudo systemctl enable ssh.service
systemctl start ssh.service

echo "Cleaning Up..."
sudo apt autoclean
sudo apt -y autoremove

echo "RECOMMEND REBOOT AFTER SCRIPT FINISHES……"
sleep 3
