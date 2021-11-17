#!/bin/bash

interface=wlan0
echo "Interface is set to $interface"
sleep 3

if [ `id -u` -eq 0 ]
then
        echo "Running as sudo user :)"
else
        echo "Please run with sudo!"
        exit 1
fi


echo "Configuring wifi adapter"   # Moved to the end


sudo ifconfig $interface down
sleep 0.1
#airmon-ng check kill
sudo iw $interface set txpower fixed 3000
sleep 0.1
sudo iwconfig wlan0 mode monitor
sleep 0.1
sudo iw $interface set txpower fixed 3000
sleep 0.1
sudo ifconfig wlan0 up
echo "MONITOR MODE!"


#sudo ip link set $interface down
#sudo iw $interface set txpower fixed 3000
#sudo iw dev $interface set type monitor
#sudo ip link set $interface up

echo "DONE!"
