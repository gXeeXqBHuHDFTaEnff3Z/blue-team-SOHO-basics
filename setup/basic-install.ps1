# please start this script in a powershell windows with admin rights
# allow script execution
$str1 = Get-ExecutionPolicy | Out-String
$str2 = "Restricted"
Write-Host $str1
IF (Compare-Object $str1 $str2)
{
    Write-Host "policy is fine as it is"   
}
ELSE
{
    Write-Host "changing policy..."  
    Set-ExecutionPolicy Bypass -Scope Process
}

# remove all windows apps except calculator
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*"} | Remove-AppxPackage -erroraction silentlycontinue
Get-AppxProvisionedPackage -online | where-object {$_.displayname -notlike "*Store*" -and $_.displayname -notlike "*Calculator*"} | Remove-AppxProvisionedPackage -online -erroraction silentlycontinue

# install chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

### install common software packages
# sources: https://chocolatey.org/packages
choco install vcredist140 # Microsoft Visual C++ Redistributable for Visual Studio
# browser and addons:
choco install firefox
choco install ublockorigin-firefox
choco install noscript
choco install tor-browser
# security:
choco install shutup10
choco install patch-my-pc
choco install keepass
choco install veracrypt
# message communication:
choco install signal
choco install thunderbird
# productivity tools:
choco install notepadplusplus --confirm
choco install 7zip
choco install jre8
choco install libreoffice-fresh
choco install winmerge
choco install mp3tag
choco install freemind
# media:
choco install vlc
choco install foxitreader
choco install pdfcreator
choco install gimp
choco install paint.net
choco install youtube-dl
choco install audacity
choco install audacity-lame
# sysadmin tools:
choco install teamviewer
choco install sysinternals
# choco install unetbootin
# latex:
# choco install miktex
# choco install texmaker
# gaming:
# choco install steam
