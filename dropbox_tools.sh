#!/bin/bash

echo "Set new sudo password for kali user before running this script!"
sleep 1

if [ `id -u` -eq 0 ]
then
        echo "Running as root user :)"
else
        echo "Please run with sudo!"
        exit 1
fi

echo "CLONING TOOLS INTO /opt"
cd /opt

echo "INSTALLING Impacket…"
git clone https://github.com/SecureAuthCorp/impacket.git

echo "INSTALLING Mitm6…"
git clone https://github.com/fox-it/mitm6

echo "INSTALLING PowerTools…"
git clone https://github.com/PowerShellMafia/PowerSploit.git

echo "INSTALLING SecLists…"
git clone https://github.com/danielmiessler/SecLists.git

echo "INSTALLING Wifi Drivers..."
sudo apt install realtek-rtl88xxau-dkms

echo "OPENING LINKS FOR OTHER TOOLS!"
sleep 1
echo "https://portswigger.net/burp/documentation/desktop/getting-started"

echo "https://www.tenable.com/downloads/nessus"

echo "https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/"

echo "https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-basic/"
