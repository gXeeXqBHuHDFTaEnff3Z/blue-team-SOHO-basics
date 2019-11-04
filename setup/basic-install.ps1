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

# install boxstarter including chocolatey package manager
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# install chocolatey package manager
# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# explorer: show file extensions
# see https://boxstarter.org/Learn/WebLauncher
Set-WindowsExplorerOptions -EnableShowFileExtensions

### install common software packages
# sources: https://chocolatey.org/packages
choco install vcredist140 # Microsoft Visual C++ Redistributable for Visual Studio
# browser and addons:
choco install firefox --confirm
choco install ublockorigin-firefox --confirm
choco install noscript --confirm
choco install tor-browser --confirm
# security:
choco install shutup10 --confirm
choco install patch-my-pc --confirm
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
# latex:
# choco install miktex --confirm
# choco install texmaker --confirm
# gaming:
# choco install steam --confirm

# install critical windows updates
Install-WindowsUpdate
# boot to desktop
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowRibbon
# windows taskbar config
Set-TaskbarOptions -Lock -AlwaysShowIconsOn

