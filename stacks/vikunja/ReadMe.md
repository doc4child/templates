
## Vikunja Installation.

* Create folders
* Assign permissions
* Download nginx configuration
```
    mkdir -p /volumes/vikunja 
    mkdir -p /volumes/vikunja/db
    mkdir -p /volumes/vikunja/files      
    chown -R 1000 /volumes/vikunja
    chmod -R 755 /volumes/vikunja
    cd /volumes/vikunja 
    wget https://raw.githubusercontent.com/doc4child/templates/master/stacks/vikunja/nginx.conf

```


Cleanup

Go to portainer and delete stack.
Remove associated volumes from host file system.

```
rm -R /bolumes/vikunja

```

