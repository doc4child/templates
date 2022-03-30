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