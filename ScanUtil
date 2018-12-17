function ScanUtil
    {$computer=Read-Host "What DOMAIN/ IP should be scanned?"
        $port=Read-Host "What Port should be scanned for? (seperate by coma)"
        $adress=[System.Net.Dns]::GetHostAddresses($computer).IPAddressToString
        $ahost=[System.Net.Dns]::GetHostByAddress($adress).hostname
        If ($adress -eq $computer)
            {Write-Host "Domain name is:" $ahost -ForegroundColor Green}
        else {Write-Host "IP adress is:" $adress -ForegroundColor Green}
        Write-Host 
            $port.split(',') | Foreach-Object -Process {
                If (($a=Test-NetConnection $computer -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) 
                    {Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Green "is open"} 
                else {Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Red "is closed"}
            }
    }
