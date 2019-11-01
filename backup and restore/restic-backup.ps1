# command for restore: 
# .\restic_*.exe -r "restic-repo" restore latest --target "<TARGET>"
# <PASSWORD>
#
# ask for password
$passfile = "restic-pwd.txt"
$pass = Read-Host 'What is your password?' -AsSecureString
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass)) > $passfile
# create repository "restic-repo"
.\restic_*.exe init -r "restic-repo" --password-file  $passfile

# backup <SOURCE> to respository
.\restic_*.exe -r "restic-repo" --verbose backup "<SOURCE>"  --password-file  $passfile

# forget old backups
# for the last 30 days, keep one each
# for the last 12 months, keep one each
.\restic_*.exe -r "restic-repo" forget --keep-daily 30 --keep-monthly 12 --password-file  $passfile

# verify integrity
.\restic_*.exe -r "restic-repo" check --read-data --password-file  $passfile

# list all snapshots in repository
.\restic_*exe -r "restic-repo" snapshots --password-file  $passfile

# remove password file
rm  $passfile
