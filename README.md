
# Arch&DebianInstConfig
## Profile
Components:
ISO(Minimalist): arch/debian/win
WM: Qtile/DWM 
Pkgmr: yay, nala
Terminal&Shell: st; bash
Launcher: demenu
FileMgr: fzf
Lockscreen: shell-based w/pswd&wallpaper
Bootloader: systemd(minimalist built-in-Linux kernel w/EFI image-just execute it)
LTS Kernel w/rolling one & config bootloader to offer both during startup(switch kernels in the event of a problem with the rolling one)

(No greeter)Always boot into the login shell by default(a show-stopping problem w/Xorg>>fix it without booting from an external drive). To launch Qtile, enter startx in the terminal. If run multiple desktops pass a path argument to startx pointing to the initialization file for the desktop you want to run.
## Usage
### Prerequisites
bootable Arch Linux USB drive.
connected to the internet.

Boot your system using the Arch Linux USB drive.
Clone this repository or download the script.
```
curl https://raw.githubusercontent.com/johnynfulleffect/ArchMatic/master/preinstall.sh -o preinstall.sh
chmod +x arch_install_script.sh
./arch_install_script.sh
```
### Pre-installation:
Sets up mirrors for optimal download (US Only).
Formats and partitions the target disk.
Installs prerequisites.
Performs file system setup.
Installs the Arch Linux base system.
### Post-installation:
Installs a set of predefined packages.
Installs the Yay AUR package manager.
Installs additional packages using Yay.
Cleans up unwanted packages.
Optionally reboots the system.
### Post-configuration:
Generates the .xinitrc file for X11 setup.
Configures the LTS Kernel as a secondary boot option.
Optimizes system settings.
Configures network settings.
Sets up UFW (Uncomplicated Firewall).
Enhances system security.
Cleans up orphaned packages.
## Initialize .gitconfig file
$ git config --global user.name "your-username"
$ git config --global user.email "your-email@gmail.com"
$ git config --global credential.helper cache
$ git config --global credential.helper 'cache --timeout=31536000'

useradd -m -G users,wheel username
echo "username:password" | chpasswd
## Initialize Xorg
At the terminal, run:
$ xinit
On subsequent logins use:
$ startx
## Warning
This script is designed for personal use and may not cover all use cases. It's highly recommended to review and customize the script to match your specific requirements before use.
## License
MIT License



# WinOSInstConfig

## Features
1.Pre-Installation Phase: Automates disk partitioning, Windows ISO download, and the creation of a bootable USB drive.
2.Post-Installation Phase: Waits for Windows installation to complete and installs a list of essential software using Chocolatey. It also configures system settings such as time zone and creates user accounts.
3.Post-Configuration Phase: Configures additional network rules, optimizes services, and performs system cleanup.
4.WinOSBackup: Offers options to backup and restore system drivers and services using Windows Backup.
5.Set-PowerShellProfile: Downloads and installs a custom PowerShell profile with additional packages and fonts.
## Usage
Clone or download this repository to your local machine.
Open PowerShell with administrative privileges.
Navigate to the directory containing the script.
```
 .\script.ps1
```
Follow the on-screen menu to select and execute the desired phase.
## Notes
Always review and customize the script to suit your specific requirements before execution.
Ensure that you have a reliable internet connection for downloading software and packages.
Backup important data before running the script, especially during the pre-installation phase.
## Author
n173sh4d0w
## License
MIT License
