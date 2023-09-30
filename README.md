
### Profile
####Components:
WM: Qtile
ISO: Arch/Debian/Gentoo



# OS_Deployment
Linux(Arch,Debian)&WinOS Qtile&DWM-based


# Minimalist_OSRicing

ISO(Minimalist): arch/debian/win
WM: Qtile/DWM 
Bar: Conky
Pkgmr: yay, nala
Terminal&Shell: st(customize under.Xresource in $HOME); bash
Launcher: fzf-keybindings
FileMgr: fzf
Lockscreen: shell-based w/pswd&wallpaper
Bootloader: systemd(minimalist built-in-Linux kernel w/EFI image-just execute it)
LTS Kernel w/rolling one & config bootloader to offer both during startup(switch kernels in the event of a problem with the rolling one)

(No greeter)Always boot into the login shell by default(a show-stopping problem w/Xorg>>fix it without booting from an external drive). To launch Qtile, enter startx in the terminal. If run multiple desktops pass a path argument to startx pointing to the initialization file for the desktop you want to run.

#####################
## Install
########################

Arch Live ISO (Pre-Install)
This step installs arch to your hard drive. IT WILL FORMAT THE DISK

### Install Reflector(fastest mirrors)&Gen mirrorlist. Note: If not in the U.S. change to nearest
$ sudo pacman -Sy && sudo pacman -S reflector rsync curl 
$ reflector --verbose --country 'United States' -l 5 --sort rate --save /etc/pacman.d/mirrorlist

### Initialize .gitconfig file
$ git config --global user.name "your-username"
$ git config --global user.email "your-email@gmail.com"
$ git config --global credential.helper cache
$ git config --global credential.helper 'cache --timeout=31536000'




curl https://raw.githubusercontent.com/johnynfulleffect/ArchMatic/master/preinstall.sh -o preinstall.sh
sh preinstall.sh

useradd -m -G users,wheel username
echo "username:password" | chpasswd
passwd
systemctl enable NetworkManager
exit

umount -R /mnt
reboot



### Arch Linux First Boot
$ pacman -S --noconfirm pacman-contrib curl git
$ cd Programs/ && git clone https://github.com/rickellis/ArchMatic.git #clone into the folder&delete it once done

### Run following scripts
$ cd ArchMatic
$ sh  ./4-bluetooth.sh 
$ sh ./5-audio.sh 
$ sh  ./6-printers.sh 

### Reboot
$ reboot

### Initialize Xorg
At the terminal, run:
$ xinit
On subsequent logins use:
$ startx


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


##

