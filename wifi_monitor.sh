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
sudo ip link set $interface down
sudo iw $interface set txpower fixed 3000
sudo iw dev $interface set type monitor
sudo ip link set $interface up

echo "DONE!"
