## Monitoring Stack installation
### Creation of following volume directories on the host file system will be needed
```
    mkdir -p /volumes/monitoring/prometheus-data/config
    mkdir -p /volumes/monitoring/grafana-data        
    cd /volumes/monitoring/prometheus-data/config
    wget https://raw.githubusercontent.com/doc4child/templates/master/stacks/monitoring/prometheus.yml
    chown -R 1000:1000 /volumes/monitoring
    chmod -R 777 /volumes/monitoring
    chmod g+s /volumes/monitoring
```


Docker volumes and file system permissions

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
RUN addgroup --gid 1024 mygroup
RUN adduser --disabled-password --gecos "" --force-badname --ingroup 1024 myuser 
USER myuser
```
(Optional) Add your host user to the group allowing you to conveniently work with the directory from your host machine
```
adduser ubuntu 1024
```

https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca
The above example is a minimal setup that ensures that you are not running the container command as root and can work with the content of attached volumes on the host without having to make use of the host root user. The setup does hard-code configuration at build time and leaves you unable to adjust the GID at runtime. If you need this you will have to pass the GID as an environment variable and include a generic script which can make use of it. 


This blog post by Deni Bertović has guide to accomplish such a setup.

https://denibertovic.com/posts/handling-permissions-with-docker-volumes/


