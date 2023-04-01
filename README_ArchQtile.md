# Minimalist_OSRicing

ISO(Minimalist): arch/debian/gentoo
WM: Qtile 
GTKThemes/Icons/Fonts:
Bar: Conky
Pkgmr: yay, nala
Terminal&Shell: urxvt&Termus(Unix shell in X environment-customizable through the .Xresource in $HOME); bash
Launcher: fzf-keybindings
File&Mgr: ranger/fzf


 Arch running qtileWM, w/all the base pkgs that allow network connectivity, bluetooth, printers, etc., and a curated selection of applications.


Bootloader: systemd(minimalist built-in-Linux kernel w/EFI image-just execute it)
LTS Kernel w/rolling one & config bootloader to offer both during startup(switch kernels in the event of a problem with the rolling one)

Set up Apache server to run w/WebServer dir located in $HOME

(No greeter)Always boot into the login shell by default(a show-stopping problem w/Xorg>>fix it without booting from an external drive). To launch Qtile, enter startx in the terminal. If run multiple desktops pass a path argument to startx pointing to the initialization file for the desktop you want to run.
To lock the screen via Slimlock(built a bunch of themes w/shell script that randomizes the choice each time lock the screen)

#####################
## Install
########################

### Install Reflector(fastest mirrors)&Gen mirrorlist. Note: If not in the U.S. change to nearest
$ sudo pacman -Sy && sudo pacman -S reflector rsync curl 
$ reflector --verbose --country 'United States' -l 5 --sort rate --save /etc/pacman.d/mirrorlist

### Initialize .gitconfig file
$ git config --global user.name "your-username"
$ git config --global user.email "your-email@gmail.com"
$ git config --global credential.helper cache
$ git config --global credential.helper 'cache --timeout=31536000'

$ cd Programs/ && git clone https://github.com/rickellis/ArchMatic.git #clone into the folder&delete it once done

### Run following scripts
$   ./4-bluetooth.sh 
$   ./5-audio.sh 
$   ./6-printers.sh 

### Reboot
$ reboot

### Initialize Xorg
At the terminal, run:
$ xinit
On subsequent logins use:
$ startx


