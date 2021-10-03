#!/bin/bash

#jumphost username
username=pentest  
echo "JUMPHOST USERNAME = $username"

#jumphost IP
ip=104.211.13.163
echo "JUMPHOST IP = $ip"

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

echo "Please enter dropbox number!"
read dropnum
scp $username@$ip:/home/$username/dropbox$dropnum.conf /home/kali/dropbox$dropnum.conf
cp /home/kali/dropbox$dropnum.conf /etc/openvpn/openvpn.conf
systemctl enable openvpn
echo "Copied and enabled dropbox openvpn file!"

echo "Please enter new hostname (companyname):"
read hostname
sudo hostnamectl set-hostname $hostname
echo "Hostname set to $hostname"

echo "UPDATING"
apt update && apt upgrade -y

echo "Installing and enabling RDP"
apt install xrdp -y
service xrdp start
service xrdp-sesman start
update-rc.d xrdp enable

echo "Disabling Sleep"
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo "REBOOTING IN 10 SECONDS……"
sleep 10

reboot
