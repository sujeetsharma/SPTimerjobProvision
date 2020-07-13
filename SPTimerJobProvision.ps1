<#Sometimes you may have come up a situation where one-time timer jobs are not running on the SharePoint servers.
Even when the instance status shows "Online"

Refer: 
https://joshroark.com/sharepoint-all-about-one-time-timer-jobs/
https://docs.microsoft.com/en-us/archive/blogs/sujesh/sharepoint-timer-jobs-not-runningspecially-one-time-timer-jobs

To bring the status online you can use below commands:

$farm = Get-SPFarm;
$farm.TimerService.Instances | Select ID, Server | FT;
$instance = $farm.TimerService.Instances | ?{$_.ID -match 'eb0adf39-79d0-438b-96a3-92c095646988'} #Where the ID is of the affected server from previous command output;
$instance.Status = [Microsoft.SharePoint.Administration.SPObjectStatus]::Online;
$instance.update();

However, even if the above command completes successfully the issue still remains. To finally solve the issue, you must use below commands to provision the timer instance using below commands.

MAKE SURE TO RUN THE BELOW COMMANDS LOCALLY ON AFFECTED SERVER USING FARM ADMIN ACCOUNT
#>
$farm = Get-SPFarm
$farm.TimerService.Instances | Select ID, Server | FT
$instance = $farm.TimerService.Instances | ?{$_.ID -match 'eb0adf39-79d0-438b-96a3-92c095646988'} #Where the ID is of the affected server from previous command output;
Get-Service -Name 'SharePoint Timer Service' | Stop-Service
$instance.Provision()
$instance.Start()
