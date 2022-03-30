# list connected disks
 ./sbin/fdisk -l
# mount USB HDD
mkdir /media/usbhdd
mount -t ntfs-3g /dev/sdb3 /media/usbhdd
cd /media/usbhdd
# show free disk space
df -h
# sime file copy backup 
./bin/rsync -avh --progress /var/lib/docker/volumes/nextcloud_data/_data/Chris/files/ /media/usbhdd/
