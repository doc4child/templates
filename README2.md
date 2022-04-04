

### Commands to prep your system, after Install:

  Update the system:

  * sudo apt update

  * sudo apt upgrade

  If you want to Install Glances: 

  * sudo glances -w

  If you want to Install CFIS Utilities to Map Network Shares: 

  * sudo apt-get install cifs-utils

  If you want to Install GIT: 

  * sudo apt install git-all

  Install and test Docker:

  * sudo apt install docker.io

  * sudo systemctl enable docker

  * sudo systemctl start docker

  * sudo systemctl status docker

  Setup Portainer: 

  * sudo docker volume create portainer_data

  * sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

** How to Update Portainer, for when needed: **

  * sudo docker stop portainer
  
  * sudo docker rm portainer
  
  * sudo docker pull portainer/portainer-ce
  
  * sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

** How to install the Portainer Agent, for when needed: **

  * docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.6.3 
  
  [Reference for the above](https://docs.portainer.io/v/ce-2.6/start/install/agent/docker/linux)


** Further Ubuntu Setup items to be Added at a Later Time: **

   ## Supplemental steps for a PiHole Container, Ubtuntu Server
   
   After pulling the container image, and it failing to start, make the following adjustments: 

   * sudo systemctl stop systemd-resolved.service

   * sudo systemctl disable systemd-resolved.service

   Next, run the below and edit the name server:

   * sudo nano /etc/resolv.conf

   You can change the name server to OpenDNS normally

   * 208.67.222.222
   * 208.67.220.220

   ## Supplimental Setup Notes
   
   Commands for Mapping a Network Share, after installing the CFIS Utilities
   
   (Please note: This is from some old notes of mine, and it will probably need to be reviewed to be sure it's within best practices)

   * sudo mkdir /mnt/*FolderNameonyourUbuntuSystem*
   * sudo chown -R nobody:nogroup /mnt/*FolderNameonyourUbuntuSystem*
   * sudo chmod -R 0755 /mnt/*FolderNameonyourUbuntuSystem*
   * sudo mount.cifs //*IPAddressofNetworkShare*/*ShareName* /mnt/*FolderNameonyourUbuntuSystem* -o user=*Username*,uid=1000
      * Enter Applicable Passwords  

   ### Further Ubuntu Setup items to be Added at a Later Time:

   1. Adding a public SSH Key to your Server 

   2. Remapping a Share at Server Boot

   3. Securing your Servers

   4. Quick access list of general Linux/Ubuntu Commands

## In the Browser Setup: 

  You Should now be able to navigate to the IP of the VM or Ubuntu Machine, going to the portainer port 9000  http://IPADress:9000

  Do initial Portainer registration 

  Configure Endpoint Setting so that the IP is set to that of the Host (basically, set the IP to the same thing you used to connect) 
      - Click Endpoints, then click the name of your VM/Server, and adjust the IP in the noted space


<img width="592" alt="5" src="https://user-images.githubusercontent.com/84437811/150960304-414ff5dd-c586-4837-a689-c462807435b1.png">


  Adjust your app template list to: https://raw.githubusercontent.com/mycroftwilde/portainer_templates/master/Template/template.json
      - Click Settings, then adjust the App Template URL, and Apply the Changes. Afterword, navigate back to the app templates and the list should refesh to be pulling from this repository


<img width="725" alt="4" src="https://user-images.githubusercontent.com/84437811/150959906-96752d7c-f49f-4d45-88e0-cfe9e99c8269.png">


 ## ** Helpful Links and URLs for Self-Hosting **
 
  * [LinuxServer.io](https://www.linuxserver.io/)

  * [Porkbun](https://porkbun.com)

  * [Cloudflare](https://www.cloudflare.com/)

  * [SiteGrounds](https://www.siteground.com/)

  * [Hotio.Dev](https://hotio.dev/)

  * [PfSense](https://www.pfsense.org/download/)
     * Note - to help with multicast traffic accross vlans for IoT devices and servers like Home Assistant the following package can be installed, and then configured: avahi

  * [Awesome Self-Hosted's Git Page](https://github.com/awesome-selfhosted/awesome-selfhosted)
  
  * [New Proxmox Host and Home Assistant Setup, Document and Video Guide - By JaunMTech](https://www.juanmtech.com/install-proxmox-and-virtualize-home-assistant/)

  * [Open Source Media Center](https://github.com/osmc/osmc) (An Open Source Media Center OS for a Raspberry Pi, etc)

  * [OpenMediaVault](https://www.openmediavault.org/)
  
  * [TrueNAS Core](https://www.truenas.com/)
  
  * [Raspberry Pi OS/Imager](https://www.raspberrypi.com/software/)

  * [Local Habitica Docker Sever Setup Instructions](https://habitica.fandom.com/wiki/Setting_up_Habitica_Locally_on_Docker)


 ## A Note about Dashboard Servers

Often you can create a server version of something you'd like to display on a wall display at home, and then use a raspberry pi to connect to that webpage on boot automatically. You can use this set of instructions, and just substitute out the dakboard specific elements, and use it to setup a raspberry pi to connect automatically to one of your running dashboard containers' URL. 

Previous Authors
* **NASHosted** - *Current Work* - [NASHOSTED](https://github.com/nashosted)
* **SelfhostedPro** - *Current Work* - [SelfhostedPro](https://github.com/SelfhostedPro)
* **Jos Visser** - *Initial work* - [Qballjos](https://github.com/Qballjos)
* **xe-nvdk** - *template conversion to portainer V2* - [xe-nvdk](https://github.com/xe-nvdk)
* **tbiering** - *Termplate cleanup and typo fixes* - [tbiering](https://github.com/tbiering)

See also the list of [contributors](https://github.com/Qballjos/portainer_templates/graphs/contributors) who participated in this project.

# My Notes

Other Templates that items were discovered/pulled from will be added when time allows. A various list of other templates have been noted below where some items have been sourced. 

[Portainer default](https://raw.githubusercontent.com/portainer/templates/master/templates-2.0.json)

[Microftwilde](https://raw.githubusercontent.com/mycroftwilde/portainer_templates/master/Template/template.json)

[Microftwilde Github](https://github.com/mycroftwilde/portainer_templates)

[technorabilia](https://raw.githubusercontent.com/technorabilia/portainer-templates/main/lsio/templates/templates-2.0.json)

[mikestraney](https://raw.githubusercontent.com/mikestraney/portainer-templates/master/templates.json)

[donPabloNow](https://raw.githubusercontent.com/donPabloNow/selfhosted-saas/master/Template/portainer-v2.json)

[xneo1](https://raw.githubusercontent.com/xneo1/portainer_templates/master/Template/template.json)


https://raw.githubusercontent.com/ntv-one/portainer/main/template.json 


https://raw.githubusercontent.com/dnburgess/self-hosted-template/master/template.json

https://raw.githubusercontent.com/Qballjos/portainer_templates/master/Template/template.json

https://raw.githubusercontent.com/SelfhostedPro/selfhosted_templates/portainer-2.0/Template/template.json

https://raw.githubusercontent.com/technorabilia/portainer-templates/main/lsio/templates/templates-2.0.json

https://raw.githubusercontent.com/mikestraney/portainer-templates/master/templates.json


https://raw.githubusercontent.com/doc4child/templates/master/templates-stacks-2.0.json



