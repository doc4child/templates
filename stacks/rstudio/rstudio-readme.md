https://github.com/TelethonKids/rstudio/blob/master/docker-compose.yml

This works:
docker run -d -p 8787:8787 --restart=always -v /volume/rstudio:/home/rstudio -v /volumes/rstudio/projects:/home/rstudio/projects -e USER=doc4child -e PASSWORD=wd2ct4et  --name rstudio rocker/rstudio



First look for id_rsa and id_rsa.pub files in the ubuntu server.
superuser@ubuntu:\~$ cd \~/.ssh
superuser@ubuntu:~/.ssh$ ls
authorized_keys  id_rsa  id_rsa.pub  known_hosts

Now copy those files to the hosted directory in rstudio
superuser@ubuntu:\~/.ssh $ cp \~/.ssh/id_rsa.pub /volumes/rstudio/home
superuser@ubuntu:\~/.ssh $ cp \~/.ssh/id_rsa /volumes/rstudio/home

Now become root in rstudio container. the same files are hosted under /home/rstudio inside that container since that folder is mapped on host directory /volueme/rstudio/home
superuser@ubuntu:~/.ssh$ docker exec -it rstudio /bin/bash

Look for those files
root@7aa78c9e1e6d:/# cd /home/rstudio
root@7aa78c9e1e6d:/home/rstudio# ls
id_rsa  id_rsa.pub  projects

copy them to rstudio user's ssh directory.
root@7aa78c9e1e6d:/home/rstudio# cp /home/rstudio/id_rsa /home/doc4child/.ssh/id_rsa
root@7aa78c9e1e6d:/home/rstudio# cp /home/rstudio/id_rsa.pub /home/doc4child/.ssh/id_rsa.pub