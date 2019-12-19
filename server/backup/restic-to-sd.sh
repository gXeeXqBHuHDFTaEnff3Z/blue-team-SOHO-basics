# backup nextcloud folder of user to sd card
USER="chris"
SOURCE1="/var/www/nextcloud/data/$USER/files/Vault"
SOURCE2="/var/www/nextcloud/data/$USER/files/Documents"
TARGET="/dev/mmcblk0p1/"
REPOSITORY="restic-repo"
PASSFILE="~restic/password.txt"

# mount sd card
mount -t vfat /dev/mmcblk0p1 /mnt/sdc1/

# if restic has not been initialized, then do it now
if [[ ! -f "~restic/bin/installed.txt" ]]
then
  # source: https://restic.readthedocs.io/en/stable/080_examples.html#backing-up-your-system-without-running-restic-as-root
  echo "[!!] Repository restic-rep does not exist. Initializing...:
  useradd -m restic
  mkdir ~restic/bin
  # download and install binary
  curl -L https://github.com/restic/restic/releases/download/v0.9.1/restic_0.9.1_linux_amd64.bz2 | bunzip2 > ~restic/bin/restic
  
  # restrict permissions to restic user and root
  chown root:restic ~restic/bin/restic
  chmod 750 ~restic/bin/restic
  setcap cap_dac_read_search=+ep ~restic/bin/restic
  
  # create repository
  echo "Create repository..."
  apg -a 1 -m 32 -n 1 -M NCL > $PASSFILE
  export RESTIC_REPOSITORY=$REPOSITORY
  export RESTIC_PASSWORD=cat $PASSFILE
  sudo -u restic /home/restic/bin/restic init
  echo "Installed on $(date)" > ~restic/bin/installed.txt
fi

# backup using restic user
echo "Backup to $TARGET"
sudo -u restic /home/restic/bin/restic -r $REPOSITORY backup $SOURCE1 $SOURCE2 --password-file $PASSFILE

# forget old backups
# for the last 30 days, keep one each
# for the last 12 months, keep one each
sudo -u restic /home/restic/bin/restic -r $REPOSITORY forget --keep-daily 30 --keep-monthly 12 --password-file $PASSFILE

# verify integrity
sudo -u restic /home/restic/bin/restic -r $REPOSITORY check --read-data --password-file $PASSFILE

# list all snapshots in repository
sudo -u restic /home/restic/bin/restic -r $REPOSITORY snapshots --password-file $PASSFILE
