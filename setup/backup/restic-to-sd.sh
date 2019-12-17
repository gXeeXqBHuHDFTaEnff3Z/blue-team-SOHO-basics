# backup nextcloud folder of user to sd card
$USER="chris"
SD="/dev/mmcblk0"
SOURCE="/var/www/nextcloud/data/$USER/files"

echo "Backup of $SOURCE to $TARGET"

TODO:
https://restic.readthedocs.io/en/stable/080_examples.html#backing-up-your-system-without-running-restic-as-root
