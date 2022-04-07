

#!/bin/bash

# Create directories
mkdir /volumes/authentication
mkdir /secrets/authentication


# Create Secrets
CURRENT_PATH=$(pwd) 

cd /secrets/authentication
touch auth_mysqldb_password.txt
touch auth_mysqldb_root_password.txt
touch auth_redis_password.txt

openssl rand -base64 20 >> auth_mysqldb_password.txt 
openssl rand -base64 20 >> auth_mysqldb_root_password.txt
openssl rand -base64 20 >> auth_redis_password.txt
cd $CURRENT_PATH


# for openldap

In this config, used live certificates and that seemed to work.
it does generate dhpram.pem file in the /volumes/npm/letsencrypt folder since that is the volume for certs. The certificate path from there onwards is mentioned in the filename environmental variable like-
   LDAP_TLS_CRT_FILENAME: /live/${npm_XX}/cert.pem

# for phpldapadmin, 

it used live certificates link to the let's encrypt certificates.

# for Nginx proxy manager
Entry for ldap.${DOMAIN}.${TLD} needed 
choose https forward using "18443" 
--forward with port 80 did not work 

Login with following credentials in the phpLDAPadmin

cn=admin,dc=${DOMAIN},dc=${TLD}
${CHANGEME}

(Optional)
cn=user-ro,dc=${DOMAIN},dc=${TLD}
Passowrd ro_pass

ref used was https://github.com/osixia/docker-openldap/issues/120
and https://github.com/Ramhm/openldap/blob/master/docker-compose.yml 

replace ${DOMAIN} ${CHANGEME} ${npm_XX} docker-network

# for configuration of authelia for ldap

https://www.authelia.com/docs/configuration/authentication/ldap.html