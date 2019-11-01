# command for restore: 
# .\restic_*.exe -r "restic-repo" restore latest --target "<TARGET>"
# <PASSWORD>
#
# create repository "restic-repo"
.\restic_*.exe init -r "restic-repo"
<PASSWORD>
<PASSWORD>

# backup <SOURCE> to respository
.\restic_*.exe -r "restic-repo" --verbose backup "<SOURCE>"
<PASSWORD>

# verify integrity
.\restic_*.exe -r "restic-repo" check --read-data
<PASSWORD>

# list all snapshots in repository
.\restic_*exe -r "restic-repo" snapshots
<PASSWORD>
