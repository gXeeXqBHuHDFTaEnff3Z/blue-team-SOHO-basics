# source: https://www.c-rieger.de/nextcloud-installation-guide-debian-9-10/
# Change into sudo mode
sudo -s
# Prepare your server for the installation itself:
apt install curl gnupg2 git lsb-release ssl-cert ca-certificates apt-transport-https tree locate software-properties-common dirmngr screen htop net-tools zip unzip curl ffmpeg ghostscript libfile-fcntllock-perl -y
# Add new software repositories
cd /etc/apt/sources.list.d
echo "deb [arch=amd64] http://nginx.org/packages/mainline/debian $(lsb_release -cs) nginx" | tee nginx.list
echo "deb [arch=amd64] https://packages.sury.org/php/ $(lsb_release -cs) main" | tee php.list
echo "deb [arch=amd64] http://mirror2.hs-esslingen.de/mariadb/repo/10.4/debian $(lsb_release -cs) main" | tee mariadb.list
# Download the required keys to trust all the new sources:
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
# Update your server and generate self signed certificates:
apt update && apt upgrade -y
make-ssl-cert generate-default-snakeoil -y
# Remove old nginx software if exists:
apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
# First ensure Apache(2) isn’t running otherwise NGINX won’t start because the required port (:80) would be in use by Apache(2):
systemctl stop apache2.service && systemctl disable apache2.service
apt install nginx -y
systemctl enable nginx.service
# Change the deafult nginx configuration:
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak && touch /etc/nginx/nginx.conf
nano /etc/nginx/nginx.conf
