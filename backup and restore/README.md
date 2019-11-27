# how to backup and restore data

## (1) requirements
- [ ] capacity for the next year: ______
- [ ] at-rest encryption
- [ ] deduplication
- [ ] automatic online backup schedule
- [ ] manual offline backup schedule

## (2) setup minimal restic backup on logon
1. open admin powershell
2. download [restic](https://github.com/restic/restic/releases/)
3. put restic.exe in <code>%userprofile%</code>
4. put [restic-to-onedrive.bat](https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/backup%20and%20restore/restic-to-onedrive.bat) there as well
5. create password file: <code>echo YOUR_PASSWORD > restic-pwd.txt</code>
5. create repository with <code>.\restic_*.exe init -r "restic-repo" --password-file "restic-pwd.txt"</code>
6. create lnk to script in <code>shell:startup</code> folder

