# source[1]: https://lehrerfortbildung-bw.de/st_digital/netz/virtual/container/docker/index.html
# source[2]: https://hub.docker.com/r/ownyourbits/nextcloudpi-x86
# install docker
apt-get install docker.io 
# test install:
# docker run hello-world
docker search nextcloudpi
docker pull ownyourbits/nextcloudpi-x86
mkdir -p /srv/docker/nextcloud/data
mkdir -p /srv/docker/nextcloud/config 
docker run -d -p 4443:4443 -p 443:443 -p 80:80 -v ncdata:/data --name nextcloudpi ownyourbits/nextcloudpi-x86 10.0.0.10
# install pihole
docker pull pihole/pihole
