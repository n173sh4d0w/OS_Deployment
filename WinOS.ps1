# Function for Pre-Installation Phase
function PreInstallation {
    Write-Host "Executing Pre-Installation Phase..."

    # Partition and format the disk (Example: Disk 0)
    New-Partition -DiskNumber 0 -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -Force -Confirm:$false

    # Download the Windows 11 ISO (replace with the actual download link)
    $isoUrl = "https://example.com/windows11.iso"
    $isoPath = "C:\path\to\windows11.iso"
    Invoke-WebRequest -Uri $isoUrl -OutFile $isoPath

    # Create a bootable USB drive (replace with the correct drive letter)
    $usbDrive = Get-WmiObject -Query "SELECT * FROM Win32_DiskDrive WHERE MediaType='Removable Media'"
    $usbDrive | ForEach-Object {
        $disk = $_
        $partition = $disk | Get-Partition
        $volume = $partition | Get-Volume
        $driveLetter = $volume.DriveLetter
        $args = "-inputfile:$isoPath -device:$driveLetter"
        Start-Process -FilePath "C:\path\to\your\tool\for\creating\bootable\usb\drive.exe" -ArgumentList $args -Wait
    }

    # Reboot the computer to start the installation
    Restart-Computer

}

# Function for Post-Installation Phase
function PostInstallation {
    Write-Host "Executing Post-Installation Phase..."

    # Wait for Windows to install (using a loop or wait for a specific file/directory)
    while (-not (Test-Path "C:\path\to\completed.txt")) {
        Start-Sleep -Seconds 30
    }

    # Install essential software (customize the list)  #bravebrowser, 7zip,gimp,keepass,typora, vim, shotcut, mpv, 
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

# Function for Post-Configuration Phase
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

# Display menu options
$MenuOptions = @{
    1 = "Pre-Installation"
    2 = "Post-Installation"
    3 = "Post-Configuration"
    4 = "Quit"
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
        4 { Write-Host "Exiting script..."; break }
        default { Write-Host "Invalid choice. Please select a valid option." }
    }
    Pause
} until ($choice -eq 4)
