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
### Install and configure NGINX ###
# First ensure Apache(2) isn’t running otherwise NGINX won’t start because the required port (:80) would be in use by Apache(2):
systemctl stop apache2.service && systemctl disable apache2.service
apt install nginx -y
systemctl enable nginx.service
# Change the deafult nginx configuration:
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
wget -q https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/nginx.conf
# Test and restart the webserver
nginx -t && service nginx restart
# Create four folders and apply the appropriate permissions:
mkdir -p /var/nc_data /var/www/letsencrypt
chown -R www-data:www-data /var/nc_data /var/www
### 2. Install and configure PHP 7.3 (fpm) ###
# The PHP repository was enabled in chapter 1 – so just perform the following statement to install PHP latest as needed by and recommended for Nextcloud:
apt update && apt install php7.3-fpm php7.3-gd php7.3-mysql php7.3-curl php7.3-xml php7.3-zip php7.3-intl php7.3-mbstring php7.3-json php7.3-bz2 php7.3-ldap php-apcu imagemagick php-imagick php-smbclient -y
# customize timezone
timedatectl set-timezone Europe/Berlin
# Backup and then tweak PHP for optimization and security reasons:
cp /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.bak
cp /etc/php/7.3/cli/php.ini /etc/php/7.3/cli/php.ini.bak
cp /etc/php/7.3/fpm/php.ini /etc/php/7.3/fpm/php.ini.bak
cp /etc/php/7.3/fpm/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf.bak
cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
sed -i "s/;env\[HOSTNAME\] = /env[HOSTNAME] = /" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;env\[TMP\] = /env[TMP] = /" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;env\[TMPDIR\] = /env[TMPDIR] = /" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;env\[TEMP\] = /env[TEMP] = /" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;env\[PATH\] = /env[PATH] = /" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/7.3/cli/php.ini
sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/7.3/cli/php.ini
sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/7.3/cli/php.ini
sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/7.3/cli/php.ini
sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/7.3/cli/php.ini
sed -i "s/;date.timezone.*/date.timezone = Europe\/\Berlin/" /etc/php/7.3/cli/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/7.3/fpm/php.ini
sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/7.3/fpm/php.ini
sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/7.3/fpm/php.ini
sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/7.3/fpm/php.ini
sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/7.3/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = Europe\/\Berlin/" /etc/php/7.3/fpm/php.ini
sed -i "s/;session.cookie_secure.*/session.cookie_secure = True/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.enable=.*/opcache.enable=1/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=128/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=1/" /etc/php/7.3/fpm/php.ini
sed -i "s/;opcache.save_comments=.*/opcache.save_comments=1/" /etc/php/7.3/fpm/php.ini
sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights=\"none\" pattern=\"EPI\"/rights=\"read|write\" pattern=\"EPI\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights=\"none\" pattern=\"XPS\"/rights=\"read|write\" pattern=\"XPS\"/" /etc/ImageMagick-6/policy.xml
# Restart both services, php and nginx:
service php7.3-fpm restart
service nginx restart
# now pray PHP was successfully installed and configured – we will go ahead with the installation of MariaDB.
### 3. Install, harden and configure MariaDB 10.4 ###
# Install MariaDB by issuing the following statement:
apt update && apt install mariadb-server -y
# Harden and secure your MariaDB by issuing:
mysql_secure_installation
# Switch to unix_socket authentication [Y/n] 
N
# Enter current password for root (enter for none):

# Set root password? [Y/n]
Y

