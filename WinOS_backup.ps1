# Set-ExecutionPolicy RemoteSigned
# .\backup.ps1

function BAK {
    Clear-Host
    Write-Host "===== WinOS Backup ====="
    Write-Host "1. Gnl Backup"
    Write-Host "2. Backup Drivers"
    Write-Host "3. Backup Services"
    Write-Host "4. Exit"
}



function Get-GnlBackup {
# Backup src host
$sourceComputer = $env:COMPUTERNAME # Grabs the name of the source computer
$backupLocation = "C:\Backup" # Replace with the desired backup location on the source computer
# Backup dst host
$destinationComputer = "COMPUTER_NAME" # Replace with the name of the destination computer
$restoreLocation = "C:\Restore" # Replace with the desired restore location on the destination computer

# Prompts
$Mode = Read-Host "Manual input? (Y/n)"
if($Mode -eq "Y"){
    Read-Host -Prompt "Source Computer Name ($sourceComputer)" -OutVariable $tmp
    $sourceComputer = $tmp -ne "" ? $tmp : $(Write-Host "No input entered, exiting"; Exit)
    
    Read-Host -Prompt "Destination Computer Name ($destinationComputer)" -OutVariable $tmp
    $destinationComputer = $tmp -ne "" ? $tmp : $(Write-Host "No input entered, exiting"; Exit)
}

# Backup src host
Write-Host "Backing up $sourceComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start backup -backupTarget:`"$backupLocation`" -include:`"C:`" -quiet"
# Restore to dst host
Write-Host "Restoring to $destinationComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start recovery -backupTarget:`"$backupLocation`" -machineName:`"$destinationComputer`" -recoveryTarget:`"$restoreLocation`" -quiet"
# End msg
Write-Host "Backup and restore completed successfully."

}

function Get-BackupDrivers {
    
    $filename = "$env:USERPROFILE\Desktop\Backup_Drivers-Services_Current-State.reg"
    $regHeader = 'Windows Registry Editor Version 5.00'

    Set-Content $filename $regHeader

    driverquery /FO CSV | ForEach-Object {
        $svc = $_.Split(",")[0].Trim('"')
        $start = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\$svc" -Name Start -ErrorAction SilentlyContinue).'Start'
        if ($start -match "[0-4]$") {
            $start = [int]$start
            $regKey = "[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]"
            $regValue = "`"Start`"=dword:0000000$start"
            $regEntry = "$regKey`n$regValue`n$regDelimiter"
            Add-Content $filename $regEntry
        }
    } > $null 2>&1
    
   Write-Host "The current configs for drivers have been backup."
}

function Get-BackupServices {
    $filename = "$env:USERPROFILE\Desktop\Backup_Windows-Services_Current-State.reg"
    
    "Windows Registry Editor Version 5.00" | Out-File $filename -Encoding ASCII
    
    Get-Service | Where-Object {$_.Name -cmatch "[a-z]" -and $_.Name -ne "TermService"} | ForEach-Object {
        $svc = $_.Name
        $start = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\$svc" -Name Start -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Start
        if ($start -match "[0-4]$") {
            $start = [int]$start
            "`n[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]" | Out-File $filename -Encoding ASCII -Append
            "`"Start`"=dword:0000000$($start)" | Out-File $filename -Encoding ASCII -Append
        }
    } > $null


    Write-Host "The current configs for services have been backup."
}



while ($true) {
    BAK
    $choice = Read-Host "Enter your choice (1-4):"
    
    switch ($choice) {
        '1' {
            Get-GnlBackup
            Read-Host "Press Enter to continue..."
        }
        '2' {
            #$directory = Read-Host "Enter the directory path to get files from:"
            #Get-FilesInDirectory $directory
            Get-BackupDrivers
            Read-Host "Press Enter to continue..."
        }
        '3' {
            #$serviceName = Read-Host "Enter the service name to restart:"
            #Restart-Service $serviceName
            Get-BackupServices
            Read-Host "Press Enter to continue..."
        }
        '4' {
            break
        }
        default {
            Write-Host "Invalid choice. Please select a valid option (1-4)."
            Read-Host "Press Enter to continue..."
        }
    }
}




























# 





# backup current configs for services
