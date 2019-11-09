$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
# show hidden files
# Set-ItemProperty $key Hidden 1
# don't hide file extensions
Set-ItemProperty $key HideFileExt 0
# restart explorer
Stop-Process -processname explorer
