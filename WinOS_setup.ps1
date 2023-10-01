# Check if the profile file does not exist, create it
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
        # Determine PowerShell edition and create profile directory if it doesn't exist
        $profileDir = if ($PSVersionTable.PSEdition -eq "Core") { "Powershell" } else { "WindowsPowerShell" }
        $profilePath = Join-Path -Path $env:userprofile -ChildPath "Documents\$profileDir"
        
        if (!(Test-Path -Path $profilePath)) {
            New-Item -Path $profilePath -ItemType Directory
        }

        # Download and install the profile
        $profileUrl = "https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1"
        Invoke-RestMethod -Uri $profileUrl -OutFile $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file already exists, show the message and do nothing.
else {
    Get-Item -Path $PROFILE | Move-Item -Destination oldprofile.ps1
    $profileUrl = "https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1"
    Invoke-RestMethod -Uri $profileUrl -OutFile $PROFILE
    Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
}

# Execute the profile
& $profile

# Install OMP
winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh

# Install Fonts
if (-not (Get-FontFamily -Name "CaskaydiaCove NF")) {
    $fontDownloadUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip"
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

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Terminal Icons
Install-Module -Name Terminal-Icons -Repository PSGallery
