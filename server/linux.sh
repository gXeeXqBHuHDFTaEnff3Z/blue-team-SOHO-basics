#!/bin/bash
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