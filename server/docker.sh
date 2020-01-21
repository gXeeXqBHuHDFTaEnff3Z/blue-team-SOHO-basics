# source: https://lehrerfortbildung-bw.de/st_digital/netz/virtual/container/docker/index.html
# install docker
apt-get install docker.io docker-compose
### install pihole ###
docker pull pihole/pihole
mkdir -p /srv/docker/pihole
cd /srv/docker/pihole
curl -O https://raw.githubusercontent.com/pi-hole/docker-pi-hole/master/docker_run.sh
# change ports and remove timezone
sed -i 's/80:80/81:80/g' docker_run.sh
sed -i 's/443:443/444:443/g' docker_run.sh
sed -i '/TZ=/d' docker_run.sh
chmod +x docker_run.sh
./docker_run.sh
# fix pihole webserver expecting localhost
# source: https://github.com/pi-hole/pi-hole/issues/2195 (unitpas)
docker exec -it pihole bash
apt-get update
apt-get install nano
sed -i 's/$serverName = htmlspecialchars($_SERVER["HTTP_HOST"]);/$serverName = htmlspecialchars($_SERVER["SERVER_ADDR"]);/g' /var/www/html/pihole/index.php
exit
### install nextcloud ###
docker pull nextcloud
docker pull mariadb
mkdir -p /srv/docker/nextcloud/data
mkdir -p /srv/docker/nextcloud/config
cd /srv/docker/nextcloud/
# setup nextcloud and mariadb with docker-compose.yaml
# source: https://github.com/nextcloud/docker/issues/540
curl -O https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/docker-compose.yaml
# create and set individual passwords
PASS=`openssl rand -base64 14`
sed -i "s/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=${PASS}/g" docker-compose.yaml
PASS=`openssl rand -base64 14`
sed -i "s/MYSQL_PASSWORD=/MYSQL_PASSWORD=${PASS}/g" docker-compose.yaml
docker-compose up -d
# check if compose was successfull
docker-compose logs
# remove the yaml because it has the passwords
# NOTE: SAVE PASSWORDS first
rm docker-compose.yaml
# data will be in ./var/lib/docker/volumes/nextcloud_data/_data/<username>/files/
### install privoxy proxy server (without TOR) on port 8118 ###
docker pull splazit/privoxy-alpine
docker run -d --restart unless-stopped --name privoxy -p 8118:8118 splazit/privoxy-alpine
### install privoxy with TOR on port 8228 ###
docker pull dperson/torproxy
docker run -it -p 8228:8118 -p 9050:9050 -d dperson/torproxy
# get a shell in the proxy and enable logging
docker exec -it privoxy sh
apk update
apk add nano
cd /etc/privoxy/
nano config
# see the log
docker ps -aqf "name=privoxy-alpine" | docker inspect --format='{{.LogPath}}' 
### samba server ###
# mount usb 
fdisk -l
cd /mnt
mkdir usb1
mount /dev/sdb3 /mnt/usb1
# source: https://hub.docker.com/r/dperson/samba
docker run -it --name samba -p 139:139 -p 445:445 \
            -v /mnt/usb1:/mount \
            -d dperson/samba -p
# mount share
docker exec -it samba samba.sh -s "video;/video"
