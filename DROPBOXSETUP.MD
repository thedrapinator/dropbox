# Chris crappy MASTER INSTALL instructions

power on and plug in ethernet

create bootable kali usb and boot from it

advanced options 

automated install

enter on everything till you get to username

username: pentest
pass: Pentest123!!!

Use entire disk

Select hard drive

remove flashdrive and reboot when completed

login as pentest

`cd /opt/`
`sudo git clone http://github.com/sirchsec/dropbox.git`

`sudo chmod +x /opt/dropbox/NAB_MASTER_INSTALL.sh`
`sudo /opt/dropbox/NAB_MASTER_INSTALL.sh`

make sure keys are copied from jumphost into github folder with the proper filename. (example: Bee1.ovpn)

enter your github username and password (or token)
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

select yes to update

enter hostname: Bee1   (select the correct number of the dropbox)

Script will install everything automatically and reboot. Then its on the vpn and ready to go.

###########################################################################################################

# OLD INSTRUCTIONS

###########################################################################################################



# Setting up Kali on Pentest DropBoxes(Udoo x86 II Advanced Plus)
Equipment used:
- Windows 10 laptop
- 2 USB thumb drives (One 8gb just for transferring files between windows machine and dropbox, one 64GB for flashing Kali ISO )
- Micro SD Card (128GB)


1. Download Kali Linux Bare Metal 64 bit Installer [https://www.kali.org/get-kali/#kali-bare-metal]
2. Reformat a micro SD card of at least 64gb (I'm using a Sandisk extereme microsdxc  128gb card [https://www.amazon.com/SanDisk-128GB-Extreme-microSD-Adapter/dp/B07FCMKK5X/ref=sr_1_2?crid=3N5TW9WZU2MXJ&dchild=1&keywords=micro+sd+sandisk&qid=1633622645&sprefix=micro+sd+san%2Caps%2C300&sr=8-2] and exFAT was default for mine)
3. Flash Baremetal Kali iSO onto USB drive (of at least 16GB- I used a 64GB PNY usb3.0 drive) using Balena Etcher [https://www.balena.io/etcher/]
4. Connect reformatted SD card, USB with the Kali iSO, eth cable to network, HDMI to a monitor, a keyboard, and power adapter to the dropbox
5. Once the device boots up, press escape multiple times and from boot menu, select Boot Manager
6. Selecct the USB device w/ kali image to boot into. From Kali screen, select graphical install
7. Install Kali (with username kali- this is so the script later works without issue; I initially selected the username "pentest")
8. Create new ovpn file for machine from openvpn server (Pentest-vpn in AWS)
- Log into the server 
- Run the "openvpn-install.sh" script with root permissions
- Select option 1 to add a new client
- Type the name of the client at the prompt
- cat the new .ovpn file in the /root directory
- copy the contents of this file (it's the openvpn config we want to use)
- paste the contents of this file into a text doc and rename it with a ".ovpn" filetype
10. Move this new .ovpn file onto a storage device (possibly another USB drive. It can be a very small one)
11. Plug the storage device with the newly created ovpn file into the dropbox
12. Copy ovpn file from storage device onto kali on dropbox in the home directory of the current user
13. `cd /opt`
14. git clone https://github.com/sirchsec/dropbox.git (may need to sudo su in order to clone it)
15. `cd dropbox`
16. `chmod +x dropbox_setup.sh dropbox_tools.sh hostname_update.sh wifi-tools.sh` (if not already root, may need sudo permissions)
17. `exit` root account if still logged into it (return to standard kali user account)
18. `sudo ./dropbox_setup.sh`
19. Set new password as the prompt reminds you (or ignore if you don't care)
20. Enter name of ovpn file in home dir (mine was Zeta0)
21. Enter a new hostname for the machine (ideally the name of the customer it will ship to after being set up properly. If no customer is known, enter the name of the device- in my case Zeta0)
22. Let the script do its thing
23. Choose yes at the screen asking for restarting services without asking (doesn't seem to matter whether yes or no is selected, but the upgrade process is less hands-on if you choose yes)
24. Wait for the script to finish updating and upgrading the kali install, and watch it install xrdp and configure it
25. The script also modifies the sleep/hibernation settings for kali so it disables the device from sleeping when powered on (don't want to lose a connection in the middle of pentesting)
26. Allow the machine to reboot
27. Open the terminal and check the network connections with ifconfig. You should see a 10.8.x.x address, which is the machine's IP on the openVPN network.
28. Veify that the ovpn file in the user's home directory has been removed (We don't want any customers getting their hands on this and being able to access our pentesting network)
29. Test the connection using ssh and rdp from your local machine (you will need your own ovpn file to connect to the openVPN pentesting network. This can be created from the openvpn server by running the "openvpn-install.sh" script, selecting option one to add a user, and providing your name)
- To test SSH from windows you can use powershell, putty, and any other ssh client (though powershell and putty are what I use). Type ssh [username]@[ip_of_kali_machine_tun0_interface] and supply the password you chose. For RDP connections I use the RDP client from my windows machine. Simply input the tunnel0 IP from the kali box and you'll be taken to an xrdp login screen. Using xorg, supply the username and password, and it should connect you to your session (NOTE: RDP only allows one GUI session at a time. If you are logged into the dropbox, you won't be able to connect via RDP. Try rebooting the dropbox and don't log in when the login screen appears. Then you should be able to RDP from a Windows/Linux machine to the dropbox)
30. Proceed to install the tools our team needs for the new kali install


# Backing up the Dropbox SD Image
This creates a backup of the SD card (ideal for a master image)that can be written to a new, blank SD (essentially copying all content)
Follow this guide detailing the process with Win32 Disk Imager:
https://www.howtogeek.com/341944/how-to-clone-your-raspberry-pi-sd-card-for-foolproof-backup/

# Change IPs of OpenVPN Clients
- `sudo nano /etc/openvpn/server/[new_file]`- edit with a list copied from /etc/openvpn/server/ipp.txt
- `sudo nano /etc/openvpn/server/server.conf` (edit line ifconfig-pool-persist ipp.txt)
- Change ipp.txt in the server-conf file to make it what you named "new_file" earlier

# Modify Pentester's VPN Route Table 
NOTE: This diables the VPN from routing all other traffic from your host machine over the vpn server (the result is significantly less congestion)

A modification needs to be made in the client ovpn file. Open the [name].ovpn file and edit add the following lines to the config:
```
route-nopull
route 10.8.0.1 255.255.255.0
```
