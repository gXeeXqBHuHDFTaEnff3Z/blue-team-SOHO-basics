# create /etc/pihole/setupVars.conf
curl -O -L https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/server/raspi/setupVars.conf
sudo mkdir /etc/pihole/
sudo mv setupVars.conf /etc/pihole/setupVars.conf
# start install using given settings
curl -L https://install.pi-hole.net | sudo bash /dev/stdin --unattended
