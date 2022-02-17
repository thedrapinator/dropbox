#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

echo #### Setting Hostname ####
echo "Enter New Host Name [dropbox name OR company name]"
read -p 'Hostname: ' hostname
sudo hostnamectl set-hostname $hostname
sed -i "s/127.0.1.1.*/127.0.1.1\t$hostname/g" /etc/hosts
echo "Hostname set to $hostname"

#########  IF YOU GET SUDO ERROR  ##########
#sudoedit -h 127.0.0.1 /etc/hosts
############################################

## OLD WAY
#echo $newhostname > /etc/hostname
#hostname -b $newhostname
#sed -i "s/127.0.1.1.*/127.0.1.1\t$hostname/g" /etc/hosts


### Reboot Prompt
read -p "Do you want to reboot? y/n: " prompt
if [[ "$prompt" =~ ^([yY][eE][sS]|[yY])$  ]]
  then
    sudo reboot
  else
    echo "Reboot Skipped. It is recommended to reboot!"
fi
