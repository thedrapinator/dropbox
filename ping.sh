#!/bin/bash

#Place this file in /opt/dropbox/ping.sh
#crontab -e
#add the following line (uncommented) and save
#0 * * * * /opt/dropbox/ping.sh

sleep 30   #Wait for boot and connect to VPN
if ping -c 1 10.8.0.1 &> /dev/null  #Ping VPN server through VPN
then
  sleep 1  #Placeholder
else
  touch /opt/dropbox/log/pingfaillog.txt   #Create file if not created
  date >> /opt/dropbox/log/pingfaillog.txt  #Write reboot date and time to log
  sleep 1   #small delay to ensure changes are saved
  sudo systemctl restart openvpn  #Rebooting openvpn has same effect as reboot
  #/sbin/shutdown -r   #soft reboot
fi
