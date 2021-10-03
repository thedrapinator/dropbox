### INSTALLING AZURE JUMPHOST ###

Under the “Basics” section, select the following:
	Resource Group: Pentest VPN
	Virtual Machine Name: OpenVPN
	Region: East US
	Image: Ubuntu Server 18.04 LTS
	Size: B1s (1 VCPUS, 1GB RAM)
	Authentication type: Password
	Username: pentest
  Password: <fill out and store securely>
	Public inbound ports: HTTP, HTTPS, SSH

Under the “Disks” section, select “SSD”

Under the Networking section, Public IP:
	Select “create new”
	Select “static” and save (Take note of this you will need it later)

Select “review and create” and create the machine

Once the machine is running, open the virtual machine settings and select “Networking”:
Select “Add inbound port rule”
Change “Destination port ranges” to 1194
Change “Protocol” to UDP
Change “Name” to “Port_1194”
Leave the rest as default and select “Add”

SSH into Public Azure IP of server using credentials chosen during setup
ssh pentest@<Public IP>
sudo apt install git
git clone http://github.com/sirchsec/dropbox.git
sudo ./azure_setup.sh

### CONFIGURING THE DROPBOX ###

Then power on the dropbox and run the dropbox setup script: 

git clone http://github.com/sirchsec/dropbox.git
chmod +x dropbox_setup.sh
sudo ./dropbox_setup.sh
	
chmod +x dropbox_tools.sh
sudo ./dropbox_tools.sh
