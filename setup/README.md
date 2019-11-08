More software via chocolatey:
https://chocolatey.org/packages

Automate with ansible:
https://galaxy.ansible.com/home

(1) allow script execution in admin powershell:
  Set-ExecutionPolicy Bypass -Scope Process

(2) install boxtstarter
  
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

(3) execute basic-install.ps1
