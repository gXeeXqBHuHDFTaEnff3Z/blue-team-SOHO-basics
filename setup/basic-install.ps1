<#
.Synopsis
   installs basic windows software
.DESCRIPTION
   will install
   - firefox with addons
   - security apps: shutup10, patch-my-pc, adwcleaner, keepass, veracrypt
   - messaging apps: signal, thunderbird
   - productivity apps: notepad++, 7zip, jre8, libreoffice, winmerge, mp3tag, freemind
   - media apps: vlc, pdfreader+creator, gimp, paint.net, youtube-dl, audacity
   - sysadmin apps: teamviewer, sysinternals
.EXAMPLE
   execute in powershell
#>
# remove all windows apps except calculator
# Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*"} | Remove-AppxPackage -erroraction silentlycontinue
# Get-AppxProvisionedPackage -online | where-object {$_.displayname -notlike "*Store*" -and $_.displayname -notlike "*Calculator*"} | Remove-AppxProvisionedPackage -online -erroraction silentlycontinue

# install chocolatey package manager
 iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

### install common software packages
# sources: https://chocolatey.org/packages
choco install vcredist140 # Microsoft Visual C++ Redistributable for Visual Studio
# browser and addons:
choco install firefox --confirm
choco install ublockorigin-firefox --confirm
choco install noscript --confirm
choco install tor-browser --confirm
# security:
choco install checksum --confirm
choco install shutup10 --confirm
choco install patch-my-pc --confirm
choco install adwcleaner --confirm
choco install keepass --confirm
choco install veracrypt --confirm
# message communication:
choco install signal --confirm
choco install thunderbird --confirm
# productivity tools:
choco install notepadplusplus --confirm
choco install 7zip --confirm
choco install jre8 --confirm
choco install libreoffice-fresh --confirm
choco install winmerge --confirm
choco install mp3tag --confirm
choco install freemind --confirm
# media:
choco install vlc --confirm
choco install foxitreader --confirm
choco install pdfcreator --confirm
choco install gimp --confirm
choco install paint.net --confirm
choco install youtube-dl --confirm
choco install audacity --confirm
choco install audacity-lame --confirm
# sysadmin tools:
choco install teamviewer --confirm
choco install sysinternals --confirm
# choco install unetbootin --confirm
# choco install screentogif
# latex:
# choco install miktex --confirm
# choco install texmaker --confirm
# gaming:
# choco install steam --confirm

