# Disable DNS server on the ubuntu server

if you deploy container without this it will result in following error
[2022-04-04 01:50:02.934 1647M] FATAL ERROR in dnsmasq core: failed to create listening socket for port 53: Address already in use
[2022-04-04 01:50:05.941 1767M] ########## FTL terminated after 21ms  (code 1)! ##########


```
sudo systemctl stop systemd-resolved.service
sudo systemctl disable systemd-resolved.service
sudo systemctl status systemd-resolved.service
```
---> it should say it is inactive.

```
ping google.com 
```
It should result in failure
```
sudo nano /etc/resolv.conf
```
edit nameserver to google's name server
```
nameserver 8.8.8.8
```
save and exit out of nano

ping to google should work now.

# Create directories
```
mkdir -p /volumes/pihole
mkdir -p /secrets/pihole
```

# Create Secrets

```
cd /secrets/pihole
touch pihole_password.txt
openssl rand -base64 20 >> pihole_password.txt 

```
--this did not work for me, still had to change password using `pihole -a -p` on host >docker exect -it pihole bash and then run that command to change password

# pihole.local

add entry in Pi-hole under whilelist for pihole.local (to enable whitelisting to avoid blocking)
add entry in nginx proxy manager to point to 10.0.0.10:8069

go to pihole.local/admin to access dashboard (you need to add admin at the end)


# add more to the blocklist

Under "group management" > Adlists add urls from firebog.

https://firebog.net/