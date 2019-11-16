# add source for package
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main"  >> /etc/apt/sources.list
# add signing keys and install ansible
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible
# add server to ansible
echo "[servers]" > /etc/ansible/hosts
echo "server" >> /etc/ansible/hosts
