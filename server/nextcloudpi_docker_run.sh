#!/bin/bash

docker run -d \
    --name nextcloudpi \
    -p 80:80 \
    -p 443:443 \
    -v "$(pwd)/data:/var/www/html/data" \
    -v "$(pwd)/config:/var/www/html/config" \
    --dns=127.0.0.1 \
    --restart=unless-stopped \
    ownyourbits/nextcloudpi-x86:latest

printf 'Starting up nextcloudpi container '
for i in $(seq 1 20); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" nextcloudpi)" == "healthy" ] ; then
        printf ' OK'
        echo -e "\n$(docker logs nextcloudpi 2> /dev/null | grep 'password:') for your nextcloudpi: https://${IP}/admin/"
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ $i -eq 20 ] ; then
        echo -e "\nTimed out waiting for nextcloudpi start, consult check your container logs for more info (\`docker logs nextcloudpi\`)"
        exit 1
    fi
done;
