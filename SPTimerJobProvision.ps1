<#
MAKE SURE TO RUN THE BELOW COMMANDS LOCALLY ON AFFECTED SERVER USING FARM ADMIN ACCOUNT
#>

$farm = Get-SPFarm
$farm.TimerService.Instances | Select ID, Server | FT
$instance = $farm.TimerService.Instances | ?{$_.ID -match 'eb0adf39-79d0-438b-96a3-92c095646988'} #Where the ID is of the affected server from previous command output;
Get-Service -Name 'SharePoint Timer Service' | Stop-Service
$instance.Provision()
$instance.Start()
