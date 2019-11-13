rem this script will backup the pictures and documents folders to a restic repo in Dropbox (via local Dropbox folder)
rem assumes: 
rem (1) Dropbox is enabled with default folder settings
rem (2) restic.exe exists in current directory
rem (3) repository is created as "restic-repo"
rem (3) restic-pwd.txt holds the repos password
.\restic.exe -r "%userprofile%\Dropbox\restic-repo" backup "%userprofile%\pictures" "%userprofile%\documents" --password-file "restic-pwd.txt"
.\restic.exe -r "%userprofile%\Dropbox\restic-repo" forget --keep-daily 30 --keep-monthly 12 --password-file "restic-pwd.txt"
