# source[1]: https://lehrerfortbildung-bw.de/st_digital/netz/virtual/container/docker/index.html
# source[2]: https://hub.docker.com/r/ownyourbits/nextcloudpi-x86
# install docker
apt-get install docker.io docker-compose
# test install:
# docker run hello-world
# pihole aufsetzen
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
# fix webserver expecting localhost
# source: https://github.com/pi-hole/pi-hole/issues/2195 (unitpas)
docker exec -it pihole bash
apt-get update
apt-get install nano
sed -i 's/$serverName = htmlspecialchars($_SERVER["HTTP_HOST"]);/$serverName = htmlspecialchars($_SERVER["SERVER_ADDR"]);/g' /var/www/html/pihole/index.php
exit
# make run automatic at startup (if docker doesn't)
# cd /etc/systemd/system/
# curl -O https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/pihole.service
# systemctl enable pihole.service 
# nextcloud aufsetzen
docker pull ownyourbits/nextcloudpi-x86
docker pull mariadb
mkdir -p /srv/docker/nextcloud/data
mkdir -p /srv/docker/nextcloud/config
cd /srv/docker/nextcloud/
# source: https://github.com/nextcloud/docker/issues/540
curl -O https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/docker-compose.yaml
PASS=`openssl rand -base64 14`
sed -i "s/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=${PASS}/g" docker-compose.yaml
PASS=`openssl rand -base64 14`
sed -i "s/MYSQL_PASSWORD=/MYSQL_PASSWORD=${PASS}/g" docker-compose.yaml
docker-compose up -d


