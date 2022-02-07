$servers = @("HOSTNAME")

Foreach ($server in $servers)
{
    $disks = Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter DriveType=3 |
        Select-Object DeviceID,
            @{'Name'='Size'; 'Expression'={[math]::truncate($_.size / 1GB)}},
            @{'Name'='Freespace'; 'Expression'={[math]::truncate($_.freespace / 1GB)}}

    $server

    foreach ($disk in $disks)
    {
        $disk.DeviceID + $disk.FreeSpace.ToString("N0") + "GB / " + $disk.Size.ToString("N0") + "GB"

     }
 }

# /Update on Dec 9, 2019/
# Note that moving forward, future PowerShell versions no longer support Get-WmiObject so if all of a sudden you see the error message like “RPC Server is unavailable”, it’s probably time to switch over to Get-CimInstance instead. The parameters are the same for Win32_LogicalDisk. Simply replace Get-WmiObject with Get-CimInstance and you are good to go.
