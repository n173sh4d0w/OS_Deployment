function PreInstallation {
    Write-Host "Executing Pre-Installation Phase..."

    # Partition and format the disk (Example: Disk 0)
    New-Partition -DiskNumber 0 -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -Force -Confirm:$false

    # Download the Windows 11 ISO (replace with the actual download link)
    $isoUrl = "https://example.com/windows11.iso"
    $isoPath = "C:\path\to\windows11.iso"
    Invoke-WebRequest -Uri $isoUrl -OutFile $isoPath

    # Create a bootable USB drive (replace with the correct drive letter)
    Get-WmiObject -Query "SELECT * FROM Win32_DiskDrive WHERE MediaType='Removable Media'" | ForEach-Object {
        $args = "-inputfile:$isoPath -device:$($_.GetPartition().GetVolume().DriveLetter)"
        Start-Process -Wait -NoNewWindow -FilePath "C:\path\to\your\tool\for\creating\bootable\usb\drive.exe" -ArgumentList $args
    }

    # Reboot the computer to start the installation
    Restart-Computer
}

function PostInstallation {
    Write-Host "Executing Post-Installation Phase..."

    # Wait for Windows to install (using a loop or wait for a specific file/directory)
    while (-not (Test-Path "C:\path\to\completed.txt")) {
        Start-Sleep -Seconds 30
    }

    # Install essential software (customize the list)
    $softwareToInstall = @("Software1", "Software2", "Software3")
    $softwareToInstall | ForEach-Object {
        choco install $_ -y
    }

    # Configure system settings (customize as needed)
    Set-TimeZone -Id "Eastern Standard Time"

    # Create user accounts (customize as needed)
    $Password = ConvertTo-SecureString -String "YourPassword" -AsPlainText -Force
    New-LocalUser -Name "NewUser" -Password $Password -FullName "Full Name" -Description "Description" -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member "NewUser"

    # Reboot the computer to apply changes
    Restart-Computer
}

function PostConfiguration {
    Write-Host "Executing Post-Configuration Phase..."

    # Configure additional settings (customize as needed)
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Enable-NetFirewallRule -DisplayName "HTTP-In" -Action Allow
    Enable-NetFirewallRule -DisplayName "HTTPS-In" -Action Allow

    # Perform system optimizations (customize as needed)
    Get-Service | Where-Object { $_.StartType -eq "Automatic" } | Set-Service -StartupType "Manual"
    Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse
    Optimize-Volume -DriveLetter C -ReTrim -Defrag -Verbose

    # Display a completion message
    Write-Host "Windows 11 system configuration completed."

    # Optionally, prompt the user to reboot the computer
    Read-Host "Press Enter to reboot the computer..."
    Restart-Computer
}

function Start-WinOSBackup {
    while ($true) {
        Clear-Host
        Write-Host "===== WinOS Backup ====="
        Write-Host "1. General Backup"
        Write-Host "2. Backup Drivers"
        Write-Host "3. Backup Services"
        Write-Host "4. Exit"

        $choice = Read-Host "Enter your choice (1-4):"

        switch ($choice) {
            '1' {
                # General Backup
                Write-Host "Backing up $env:COMPUTERNAME..."
                Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start backup -backupTarget:`"C:\Backup`" -include:`"C:`" -quiet"
                Write-Host "Restoring to COMPUTER_NAME..."
                Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start recovery -backupTarget:`"C:\Backup`" -machineName:`"COMPUTER_NAME`" -recoveryTarget:`"C:\Restore`" -quiet"
                Write-Host "Backup and restore completed successfully."
                Read-Host "Press Enter to continue..."
            }
            '2' {
                # Backup Drivers
                $filename = "$env:USERPROFILE\Desktop\Backup_Drivers-Services_Current-State.reg"
                "Windows Registry Editor Version 5.00" | Set-Content $filename -Encoding ASCII
                driverquery /FO CSV | ForEach-Object {
                    $svc = $_.Split(",")[0].Trim('"')
                    $start = [int]$svc[-1]
                    if ($start -match "[0-4]$") {
                        $regKey = "[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]"
                        $regValue = "`"Start`"=dword:0000000$start"
                        $regEntry = "$regKey`n$regValue`n$regDelimiter"
                        Add-Content $filename $regEntry
                    }
                }
                Write-Host "The current configs for drivers have been backed up."
                Read-Host "Press Enter to continue..."
            }
            '3' {
                # Backup Services
                $filename = "$env:USERPROFILE\Desktop\Backup_Windows-Services_Current-State.reg"
                "Windows Registry Editor Version 5.00" | Set-Content $filename -Encoding ASCII
                Get-Service | Where-Object { $_.Name -match "[a-z]" -and $_.Name -ne "TermService" } | ForEach-Object {
                    $svc = $_.Name
                    $start = [int]$_.StartType
                    if ($start -match "[0-4]$") {
                        $regKey = "[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]"
                        $regValue = "`"Start`"=dword:0000000$start"
                        $regEntry = "$regKey`n$regValue`n$regDelimiter"
                        Add-Content $filename $regEntry
                    }
                }
                Write-Host "The current configs for services have been backed up."
                Read-Host "Press Enter to continue..."
            }
            '4' {
                return
            }
            default {
                Write-Host "Invalid choice. Please select a valid option (1-4)."
                Read-Host "Press Enter to continue..."
            }
        }
    }
}

function Set-PowerShellProfile {
    function Download-And-Install-Profile {
        param (
            [string]$profileUrl
        )

        $profileDir = if ($PSVersionTable.PSEdition -eq "Core") { "Powershell" } else { "WindowsPowerShell" }
        $profilePath = Join-Path -Path $env:userprofile -ChildPath "Documents\$profileDir"

        if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
            try {
                if (!(Test-Path -Path $profilePath)) {
                    New-Item -Path $profilePath -ItemType Directory
                }

                Invoke-RestMethod -Uri $profileUrl -OutFile $PROFILE
                Write-Host "The profile @ [$PROFILE] has been created."
            }
            catch {
                throw $_.Exception.Message
            }
        }
        else {
            Get-Item -Path $PROFILE | Move-Item -Destination oldprofile.ps1
            Invoke-RestMethod -Uri $profileUrl -OutFile $PROFILE
            Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
        }
    }

    function Install-Fonts {
        param (
            [string]$fontDownloadUrl
        )

        if (-not (Get-FontFamily -Name "CaskaydiaCove NF")) {
            $fontPath = Join-Path -Path $PSScriptRoot -ChildPath "CascadiaCode.zip"
            $fontExtractPath = Join-Path -Path $PSScriptRoot -ChildPath "CascadiaCode"
            $fontDestination = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Fonts)

            Invoke-WebRequest -Uri $fontDownloadUrl -OutFile $fontPath
            Expand-Archive -Path $fontPath -DestinationPath $fontExtractPath -Force

            Get-ChildItem -Path $fontExtractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                $fontFile = $_
                if (-not (Test-Path (Join-Path -Path $fontDestination -ChildPath $fontFile.Name))) {
                    Copy-Item -Path $fontFile.FullName -Destination $fontDestination
                }
            }

            Remove-Item -Path $fontExtractPath -Recurse -Force
            Remove-Item -Path $fontPath -Force
        }
    }

    function Install-ProfileAndPackages {
        $profileUrl = "https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1"
        Download-And-Install-Profile -profileUrl $profileUrl
        & $PROFILE
        winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
        $fontDownloadUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip"
        Install-Fonts -fontDownloadUrl $fontDownloadUrl
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Install-Module -Name Terminal-Icons -Repository PSGallery
    }

    function Initialize-Profile {
        $profileUrl = "https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1"
        Download-And-Install-Profile -profileUrl $profileUrl
        Install-ProfileAndPackages
    }
}

$MenuOptions = @{
    1 = "Pre-Installation"
    2 = "Post-Installation"
    3 = "Post-Configuration"
    4 = "Start-WinOSBackup"
    5 = "Set-PowerShellProfile"
    6 = "Quit"
}

do {
    Clear-Host
    Write-Host "Select a phase to execute:"
    $MenuOptions.GetEnumerator() | ForEach-Object {
        Write-Host "$($_.Key): $($_.Value)"
    }
    $choice = Read-Host "Enter the number of your choice"

    switch ($choice) {
        1 { PreInstallation }
        2 { PostInstallation }
        3 { PostConfiguration }
        4 { Start-WinOSBackup }
        5 { Set-PowerShellProfile } 
        6 { Write-Host "Exiting script..."; break }
        default { Write-Host "Invalid choice. Please select a valid option." }
    }
    Pause
} until ($choice -eq 6)
