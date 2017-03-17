## This script takes your start menu and puts it as the initial start menu for all users.
## This script also allows users to make individual changes to the start menu
## tested on Windows 2012r2

##  directions:
##  install all your programs and customize the start screen that you want for everyone
##  launch this script as administrator or launch powershell as administrator and paste the scripts.



Export-StartLayout -As BIN -Path CustomStartScreenLayout.bin

Import-StartLayout -LayoutPath .\CustomStartScreenLayout.bin -MountPath $env:SystemDrive\
