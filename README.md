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



# Docker volumes and file system permissions

Docker containers are ephemeral (don’t persist data across runs). Most useful applications need some persistent storage. The volume feature offers a way to support this requirement, but it comes with some gotchas regarding file system permissions.

In most deployed setups you will be using a container orchestration mechanism and persistent storage is provided by some public cloud product which may have it’s own way of configuring permissions. However, during local development or in the early iterations of a product the easiest thing is to expose a host directory as a docker volume.
In short these are the facts to be aware of when configuring a host directory as a volume:

The file permissions set on content in the volume are identical from the perspective of host as well as container.
Only UIDs (user ids) and GIDs (group ids) matter. For example names and passwords of users and groups do not need to match or even exist in both host and container

The container OS enforces file permissions on all operations made in the container runtime according to its own configuration. For example, if a user A exists in both host and container, adding user A to group B on the host will not allow user A to write to a directory owned by group B inside the container unless group B is created inside the container as well and user A is added to it.

By default the command of a container is run as root

It is possible (on a unix-based system) to set file/directory ownership to a GID which does not belong to any actual group

If you keep the above facts in mind you should be able to configure your containers and volumes without too many surprises. If you’re not familiar with UNIX file permissions I can recommend the official Ubuntu FilePermission wiki page.

An example of how you might configure things conveniently for local development:
Set group ownership of the directory to be used as volume to some GID (in this example 1024) not used on any actual groups on the host

```
chown :1024 /data/myvolume
```
Change permissions on the directory to give full access to members of the group (read+write+execute)
```
chmod 775 /data/myvolume
```
Ensure all future content in the folder will inherit group ownership
```
chmod g+s /data/myvolume
```
Create a user in the Dockerfile which is member of the 1024 group
```
RUN addgroup --gid 1024 nogroup
RUN adduser --disabled-password --gecos "" --force-badname --ingroup 1024 nobody
USER nobody
```
(Optional) Add your host user to the group allowing you to conveniently work with the directory from your host machine
```
adduser ubuntu 1024
```

https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca
The above example is a minimal setup that ensures that you are not running the container command as root and can work with the content of attached volumes on the host without having to make use of the host root user. The setup does hard-code configuration at build time and leaves you unable to adjust the GID at runtime. If you need this you will have to pass the GID as an environment variable and include a generic script which can make use of it. 


This blog post by Deni Bertović has guide to accomplish such a setup.

https://denibertovic.com/posts/handling-permissions-with-docker-volumes/


# Portainer App Templates for LinuxServer.io Docker containers

These [Portainer App Templates](https://documentation.portainer.io/v2.0/settings/apps/) can be used to easily deploy [LinuxServer.io Docker containers](https://hub.docker.com/u/linuxserver/) with predefined settings.

I have modified original templates to reflect the updated timezone, users of 1000 and group of 1000 for Ubuntuserver

The templates are based on data provided by the [LinuxServer.io GitHub repositories](https://github.com/linuxserver).

Please keep the following in mind.
* The templates are not supported by LinuxServer.io
* The templates are being generated so I cannot accept requests to add templates

Credit goes to Simon of [technorabilia.com](https://www.technorabilia.com/)
Detailed information about installing and using the templates and more can be found [here](https://www.technorabilia.com/portainer-app-templates-for-linuxserver-io-docker-containers).
