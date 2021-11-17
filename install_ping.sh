#!/bin/bash

#Sudo Check
if [ `id -u` -eq 0 ]
then
        echo "Running as user with sudo privs :)"
else
        echo "Please run with standard (NON ROOT) user and sudo!"
        exit 1
fi


echo "###### INSTALLING PING CONNECTION SCRIPT ######"
sudo chmod +x /opt/dropbox/ping.sh
sudo echo "0 * * * * /opt/dropbox/ping.sh" >> /etc/crontab
