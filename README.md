
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



# WinOS

## A. backup.ps1 

## B. Enhanced(stylish&functional) PowerShell Terminal
profile.ps1, setup.ps1(to auto-activate profile.ps1)

### One Line Install
Execute the following command in an elevated PowerShell window to install the PowerShell profile:

irm "https://github.com/n173sh4d0w/PowerShellScripts_WinOS/raw/main/setup.ps1" | iex

### Fix the Missing Font
After running the script, downloaded cove.zip file in current exec script dir. Steps to install the required nerd fonts:

Extract the cove.zip file.
Locate&install the nerd fonts.
