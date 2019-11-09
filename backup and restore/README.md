# how to backup and restore data

## (1) requirements
- [ ] capacity for the next year: ______
- [ ] at-rest encryption
- [ ] deduplication
- [ ] automatic online backup schedule
- [ ] manual offline backup schedule

## (2) setup

(1) open admin powershell
(2) download [restic](https://github.com/restic/restic/releases/)
(3) put restic.exe in <code>%userprofile%</code>
(4) put [restic-backup.bat](https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/backup%20and%20restore/restic-backup.bat) there as well
(5) create repository with <code>.\restic_*.exe init -r "restic-repo" --password-file  $passfile</code>
(6) create lnk to script in <code>shell:startup</code> folder

