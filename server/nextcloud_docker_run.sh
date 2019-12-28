#!/bin/bash

docker run -d \
    --name nextcloud \
    -p 80:80 \
    -p 443:443 \
    -p 4443:4443 \
    -v nextcloud:/var/www/html \
    -v config:/var/www/html/config \
    -v data:/var/www/html/data \
    --dns=127.0.0.1 \
    --restart=unless-stopped \
    nextcloud:latest 10.0.0.4
    
docker run -d \
    --name mariadb \
    -v db:/var/lib/mysql \
    mariadb:latest
