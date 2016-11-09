# This script provides the ability to add/remove a domain user
# or group from a localgroup on a computer attatched to a domain.
# Not only can you perform the action on just one computer, but
# you can perform the action on an entire OU of a domain. 

# Please review the code prior to running and be sure you 
# want to complete the action. If you have any doubts on running
# this script, the do not run it.

# You will need to have admin privleges on the target machines. 

# Future plans:
#    Add final confirmation to perform action
#    Add logging abilities.  

#add or delete. validate
    do{
        $addDelete = Read-Host "Add or Remove from local group?"
        if($addDelete -eq 'add' -OR $addDelete -eq 'remove'){
        $addDelVal = $true 
        }
        Else {
        $addDelVal = $false
        write-Host "please type 'add' , 'remove' , or press ctrl c to cancel"
        }
      } until ($addDelVal)

      #if statement for grammer
      if ($addDelete -eq 'add'){$toFrom = "to"}
      else {$toFrom = "from"}

 #localgroup to add/remove
  $localGroup = read-host "What localgroup do you want to $addDelete $tofrom"
 
 #AD user/group to add to localgroup
  $adObject = Read-Host "Name of the username or group to add to the localgroup '$localgroup'"
  

#Name of Domain
   $domain= read-host "Domain Name"

#choose a single computer or complete OU
    do{
        $ouChoice = read-host "Do you want to affect a single computer or an entire OU? Press 1 for single computer, 2 for an entire OU"
        if($ouChoice -eq 1 -OR $ouChoice -eq 2){
        $ouChoiceVal = $true
        }
        Else {
        $ouChoiceVal = $false
        Write-Host "Please press 1 , 2 , or ctrl c to cancel"}
     } Until ($ouChoice)

#Running statement
    #if single computer
  if ($ouChoice -eq 1){
  $computer= read-host "computer name"
  }
    #if get OU
  if ($ouChoice -eq 2){
  $ou = read-host 'full path to OU. Example. "OU=Computers, OU=Test, DC=example, DC=net" '
  }

  #if run single computer
  if ($ouChoice -eq 1){
  $adcomputers = Get-ADComputer  $computer }
  #if entire OU
  else {
  $adcomputers = Get-ADComputer -SearchBase $ou -Filter *}

  #Script to add/remove
  foreach ($computer in $adcomputers){
     $cn = $computer.DNSHostName
     $setGroup = [ADSI]("WinNT://$cn/$localgroup,group")
     $setGroup.$addDelete("WinNT://$domain/$adObject")
     }

