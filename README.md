# ScanUtil
Utility to scan Host for open ports

PS C:\Windows\System32\WindowsPowerShell> function ScanUtil
>>     {$computer=Read-Host "What DOMAIN/ IP should be scanned?"
>>         $port=Read-Host "What Port should be scanned for? (seperate by coma)"
>>         $adress=[System.Net.Dns]::GetHostAddresses($computer).IPAddressToString
>>         $ahost=[System.Net.Dns]::GetHostByAddress($adress).hostname
>>         If ($adress -eq $computer)
>>             {Write-Host "Domain name is:" $ahost -ForegroundColor Green}
>>         else {Write-Host "IP adress is:" $adress -ForegroundColor Green}
>>         $port.split(',') | Foreach-Object -Process {
>>             If (($a=Test-NetConnection $computer -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true)
>>                 {Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Green "is open"}
>>             else {Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Red "is closed"}
>>         }
>>     }
PS C:\Windows\System32\WindowsPowerShell> ScanUtil
What DOMAIN/ IP should be scanned?: google.ca
What Port should be scanned for? (seperate by coma): 80,443,128
IP adress is: 216.58.210.3
google.ca Port 80 is open
google.ca Port 443 is open
google.ca Port 128 is closed
PS C:\Windows\System32\WindowsPowerShell>
