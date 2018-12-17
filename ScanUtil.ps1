function ScanUtil
{
    ## Get info on host/ port/s
    $computer = Read-Host "`nEnter IP adress or qualified domain name"
    $port = Read-Host "`nSeperate multiple ports that should be scanned by`ncomma or press enter to scan a standard set of ports"

    ## Set port variable to set of standard ports when nothing has been entered
    if (!$port)
    {
        $port = "21","22","23","80","443"
        Write-Host "`nScanning for standard ports."
    }

    ## Actually get IP of host or domain of IP
    $adress = [System.Net.Dns]::GetHostAddresses($computer).IPAddressToString
    $ahost = [System.Net.Dns]::GetHostByAddress($adress).hostname

    ## Decide if IP or Domain has been entered
    if ($adress -eq $computer) 
    {
        Write-Host "`nDomain name is:" $ahost -ForegroundColor Green "`n"
    } 
    else 
    {
        Write-Host "`nIP adress is:" $adress -ForegroundColor Green "`n"
    }

    ## Seperate loop for every port entered
    $port.split(',') | Foreach-Object -Process {
        if (($a = Test-NetConnection $computer -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) 
        {
            Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Green "is open"
        } 
        else 
        {
            Write-Host $a.Computername"Port" $a.RemotePort -ForegroundColor Red "is closed"
        }
    }
    Write-Host
}
