
#!/bin/bash
# This script will install the following applications:
# - PiHole
# - Veracrypt
#
# you can make it usable by exceuting the following command:
# chmod +x ~/raspberrypi-install.sh
#
# === system update ===
# clear terminal window
clear				
# update time and linux kernel
echo "Synchronizing date & time..."
sudo ntpdate -s time.nist.gov

echo "Updating RTC..."
sudo hwclock -w

echo "Updating all packages..."
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get dist-upgrade

echo "Done!"
# === install pihole ===
curl -sSL https://install.pi-hole.net | bash
# === install OpenVPN ===
# source: https://www.kuketz-blog.de/pivpn-raspberry-pi-mit-openvpn-raspberry-pi-teil3/
curl -L https://raw.githubusercontent.com/pivpn/pivpn/master/auto_install/install.sh | bash
# make vpn use pihole dns
sed -i 's/push "dhcp-option DNS \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"/push "dhcp-option DNS 10.8.0.1"/g' /etc/openvpn/server.conf
# make pihole accept input from vpn
echo interface=tun0 >> /etc/dnsmasq.d/02-pivpn.conf
# restart services to load config
/etc/init.d/openvpn restart
/etc/init.d/pihole-FTL restart
# === install veracrypt ===
# install dependencies
sudo apt-get install libfuse-dev libfuse2 makeself libwxbase3.0-0v5 openssl
# install veracrypt
sudo apt-get install veracrypt 
# show version
veracrypt --version
