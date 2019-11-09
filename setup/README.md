More software via chocolatey:
https://chocolatey.org/packages

Automate with ansible:
https://galaxy.ansible.com/home

(1) open admin powershell

(2) dowload and execute [basic-install.ps1](https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/setup/basic-install.ps1) to downloads folder

<code>
  cd %USERPROFILE%\Downloads
  
  curl https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/setup/basic-install.ps1
  
  Get-Content basic-install.ps1 | PowerShell.exe -noprofile - 
</code>

(3) install will be in
C:\ProgramData\chocolatey\lib
