#!/bin/bash

docker run -d \
    --name nextcloudpi \
    -p 80:80 \
    -p 443:443 \
    -p 4443:4443 \
    -v "$(pwd)/data:/var/www/html/data" \
    -v "$(pwd)/config:/var/www/html/config" \
    --dns=127.0.0.1 \
    --restart=unless-stopped \
    ownyourbits/nextcloudpi-x86:latest 10.0.0.4
