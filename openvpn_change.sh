#!/bin/bash

username=pentest
#hostname=master
#filename=master.ovpn

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as user with sudo privs :)"
else
        echo "Please run with standard (NON ROOT) user and sudo!"
        exit 1
fi


#dropbox username
#echo "Please enter dropbox username! (usually pentest)"
#read username
#echo "USERNAME = $username"

echo "Please enter the ovpn file name which will be copied from the /home/$username/ folder!"
read -p 'Filename: ' filename

# if ovpn file does not exist then exit
if [ ! -f /home/$username/$filename ]
then
    echo "$filename not found. Exiting!"
    exit 1
else
    echo "File found. Copying now..."
fi

sudo cp /home/$username/$filename /etc/openvpn/openvpn.conf
#sudo rm /home/$username/$filename
sudo systemctl enable openvpn
echo "Copied and enabled dropbox openvpn file!"


echo #### Setting Hostname ####
echo "Enter New Host Name [dropbox name]"
read -p 'Hostname: ' hostname
sudo hostnamectl set-hostname $hostname
echo "Hostname set to $hostname"


### Reboot Prompt
read -p "New openvpn cert ($filename) is installed. Do you want to reboot? y/n: " prompt
if [[ "$prompt" =~ ^([yY][eE][sS]|[yY])$  ]]
  then
    echo "REBOOTING IN 5 SECONDS......."
    sleep 5
    sudo reboot
  else
    echo "Reboot Skipped. It is recommended to reboot!!!!!!"
fi
