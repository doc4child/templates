# App Templates

This repository hosts combination of templates from official repository as well as several others and some of my own templates

For more information about the template definition format and how to deploy your own templates, see the [relevant documentation section](https://documentation.portainer.io/v2.0/templates/deploy_stack/).


# This repositories tries to use following

## setup

docker containers behind nginx-reverse-proxy

## Network 

docker-network

## PUID and PGID:

1000

## Password

changeme

## Organization
* Stacks in stacks folder
* each stack inside overall directory
* config files in this directory.
* .sh script to install the configurations

## Volumes 

They are located at 

/volumes/stack_name/container_name/ +/-config folder


# NAS to Ubuntu mount
[Reference](https://www.qnap.com/en-us/how-to/knowledge-base/article/how-to-enable-and-setup-host-access-for-nfs-connection)
```
sudo mount -t nfs 10.0.0.100:/share/Multimedia /mnt -o vers=4
```

Open the /etc/fstab file with your text editor :
```
sudo nano /etc/fstab
```
Copy
Add the following line to the file: /etc/fstab

```
# <file system>                <dir>       <type>   <options>   <dump>	<pass>
10.0.0.100:/share/Multimedia   /mnt         nfs      defaults    0       0
```

Run the mount command in one of the following forms to mount the NFS share:
```
mount /mnt
mount 10.0.0.100:/share/Multimedia
```

The mount command, will read the content of the /etc/fstab and mount the share.

Next time you reboot the system the NFS share will be mounted automatically.

# to mount local folder

make that folder available in exports -
```
sudo nano /etc/exports
```
add following line and save /etc/exports
```
/volumes  127.0.0.0/24(rw,nohide,insecure,no_subtree_check,async)
```
restart nfs-server.service
```
sudo systemctl restart nfs-server.service
```

in order to mount available export add them to /etc/fstab, this will automount them on next boot.
```
sudo nano /etc/fstab
```
For network LAN device use it's ip like 10.0.0.25 here
For same server use 127.0.0.1, specify mount directory
```
# <file system>                <dir>              <type>   <options>   <dump>  <pass>
10.0.0.100:/share/Multimedia    /mnt/Multimedia    nfs      defaults    0       0
127.0.0.1:/volumes              /mnt/volumes       nfs      defaults    0       0
```
Once these entries are added, they can be manually mounted using
```
mount /mnt/volumes
```
# Portainer App Templates for LinuxServer.io Docker containers

These [Portainer App Templates](https://documentation.portainer.io/v2.0/settings/apps/) can be used to easily deploy [LinuxServer.io Docker containers](https://hub.docker.com/u/linuxserver/) with predefined settings.

I have modified original templates to reflect the updated timezone, users of 1000 and group of 1000 for Ubuntuserver

The templates are based on data provided by the [LinuxServer.io GitHub repositories](https://github.com/linuxserver).

Please keep the following in mind.
* The templates are not supported by LinuxServer.io
* The templates are being generated so I cannot accept requests to add templates

Credit goes to Simon of [technorabilia.com](https://www.technorabilia.com/)
Detailed information about installing and using the templates and more can be found [here](https://www.technorabilia.com/portainer-app-templates-for-linuxserver-io-docker-containers).
