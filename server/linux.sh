#!/bin/bash
# disable ipv6
/sbin/sysctl -w net.ipv6.conf.all.disable_ipv6=1
/sbin/sysctl -w net.ipv6.conf.default.disable_ipv6=1
# basic os update
apt-get update && apt-get upgrade
# install basic tools
su
apt-get install sudo
sudo apt-get install curl -y
sudo apt-get install ethtool 
sudo apt-get install sysstat -y
# restic
sudo apt-get install restic -y
# intel microcode
sudo apt-get install intel-microcode -y
# alias sudo to please
# source: https://twitter.com/kathyra_/status/1160812366293901314?lang=de
echo "alias please='sudo \$(fc -ln -1)'" >> ~/.bashrc
source ~/.bashrc
# network config
curl -O https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/interfaces /etc/network/interfaces
