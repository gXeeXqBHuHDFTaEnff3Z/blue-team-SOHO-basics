# copy etc files
cp etc/hosts /etc/hosts
cp etc/sudoers /etc/sudoers
# generate public key
ssh-keygen -b 4096
# copy public key to server
ssh-copy-id -i .ssh/key_rsa.pub chris@192.168.188.2
# login via ssh key:
ssh -i .ssh/key_rsa chris@192.168.188.2
