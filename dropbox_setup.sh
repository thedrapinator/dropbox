#!/bin/bash

#jumphost username
#echo "Please enter jumphost username!"
#read username
#echo "JUMPHOST USERNAME = $username"

#jumphost IP
#echo "Please enter jumphost public IP address!"
#read ip
#echo "JUMPHOST IP = $ip"

echo "Set new sudo password for kali user before running this script!"
sleep 1

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as root user :)"
else
        echo "Please run with sudo!"
        exit 1
fi

echo "Please enter the ovpn file name which will be copied from jumphost home folder!"
read filename
#sudo scp $username@$ip:/home/$username/$filename /home/kali/$filename
sudo cp /home/kali/$filename /etc/openvpn/openvpn.conf
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

echo "Disabling Sleep"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#Script out lid close action but for now: 
echo "Go into Tweak tool. Click on power. There is an option to not suspend when lid is closed."

echo "REBOOTING IN 10 SECONDS……"
sleep 10

sudo reboot
