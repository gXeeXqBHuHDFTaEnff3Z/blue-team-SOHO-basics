More software via chocolatey:
https://chocolatey.org/packages

Automate with ansible:
https://galaxy.ansible.com/home

(1) open admin powershell

(2) install boxstarter

<code></code><code>PowerShell  
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force
</code><code></code>

(3) dowload [basic-install.ps1](https://raw.githubusercontent.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/master/setup/basic-install.ps1) to downloads folder
  
(3) execute basic-install.ps1 from powershell

<code></code><code>PowerShell  
  Get-Content basic-install.ps1 | PowerShell.exe -noprofile - 
</code><code></code>
