###Xorg/Qtile/Network-BlueTooth-Audio-printersComponents/
#!/usr/bin/env bash

echo
echo "INSTALLING XORG"
echo

PKGS=(
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-xinit'            # XOrg init
        'xf86-video-intel'      # 2D/3D video driver
        'xserver-xorg-input-synaptics'  #
        'xf86-input-synaptics'  #touchpad driver
        
        'qtile'                 # Qtile Desktop
        
        'wpa_supplicant'            # Key negotiation for WPA wireless networks
        'dialog'                    # Enables shell scripts to trigger dialog boxex
        'networkmanager'            # Network connection manager
        'openvpn'                   # Open VPN support
        'networkmanager-openvpn'    # Open VPN plugin for NM
        'networkmanager-vpnc'       # Open VPN plugin for NM. Probably not needed if networkmanager-openvpn is installed.
        'network-manager-applet'    # System tray icon/utility for network connectivity
        'dhclient'                  # DHCP client
        'libsecret'                 # Library for storing passwords
        
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
        'bluez-firmware'        # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
        'blueberry'             # Bluetooth config tool
        'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
        'bluez-libs' 
    #Soundcard: Alsa(alsamixer)&Pulseaudio(pavucontrol)
         'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
         'alsa-plugins'      # ALSA plugins
         'alsa-firmware'
         'pulseaudio'        # Pulse Audio sound components
         'pulseaudio-alsa'   # ALSA configuration for pulse audio
         'pavucontrol'       # Pulse Audio volume control
   
         
         'cups'                  # Open source printer drivers
    'cups-pdf'              # PDF support for cups
    'ghostscript'           # PostScript interpreter
    'gsfonts'               # Adobe Postscript replacement fonts
    'hplip'                 # HP Drivers
    'system-config-printer' # Printer setup  utility
    
    
    # SYSTEM --------------------------------------------------------------

    'linux-lts'             # LTS kernel, uname -r 
    'linux-lts-headers'

    # TERMINAL UTILITIES --------------------------------------------------

    'bash-completion'       # Tab completion for Bash
    'curl'                  # Remote content retrieval
    'wget'                  # Remote content retrieval
   # 'elinks'                # Terminal based web browser
    'feh'                   # Terminal-based image viewer/manipulator
    #''         # Archive utility
    #'gnome-keyring'         # passwordmgr
    'ufw'                   # Firewall manager
    'hardinfo'              # Hardware info app
    'htop'                  # Process viewer
    'inxi'                  # System information utility
    'jq'                    # JSON parsing library
    'jshon'                 # JSON parsing library
    'neofetch'              # Shows system info when you launch terminal
    'ntp'                   # Network Time Protocol to set time via network.
    'numlockx'              # Turns on numlock in X11
    'screenkey'             #
    'openssh'               # SSH connectivity tools
    'rsync'                 # Remote file sync utility
    'speedtest-cli'         # Internet speed via terminal
    'terminus-font'         # Font package with some bigger fonts for login terminal
    'tlp'                   # Advanced laptop power management
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'p7zip-plugins'
    'xfce4-terminal'        # Terminal emulator
    'zenity'                # Display graphical dialog boxes via shell scripts


    # DISK UTILITIES ------------------------------------------------------

    'autofs'                # Auto-mounter
    'exfat-utils'           # Mount exFat drives
    'gparted'               # Disk utility
    'gnome-disks'           # Disk utility
    'ntfs-3g'               # Open source implementation of NTFS file system
    'parted'                # Disk utility

    # GENERAL UTILITIES ---------------------------------------------------

    'fzf'                   # Filesystem search
    'ranger'                # Filesystem Mgr
    'veracrypt'             # Disc encryption utility

    # DEVELOPMENT ---------------------------------------------------------

    'vim'                   # Text editor
   # 'apache'                # Apache web server
    'cmake'                 # Cross-platform open-source make system
    'git'                   # Version control system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
   # 'nodejs'                # Javascript runtime environment
   # 'npm'                   # Node package manager
    'php'                   # Web application scripting language
   #'php-apache'            # Apache PHP driver
   #'postfix'               # SMTP mail server
    'python'                # Scripting language
    #'yarn'                  # Dependency management (Hyper needs this)

    # WEB TOOLS -----------------------------------------------------------

#Confirm    'brave-nightly-bin'     # Web browser
    #'filezilla'             # FTP Client

    # COMMUNICATIONS ------------------------------------------------------


    # MEDIA ---------------------------------------------------------------

    'ffmpeg'                # Media
    'flameshot'             # Screen capture.

    # GRAPHICS AND DESIGN -------------------------------------------------

    'gimp'                  # GNU Image Manipulation Program
    #'imagemagick'           # Command line image manipulation tool

    # PRODUCTIVITY --------------------------------------------------------

    'hunspell'              # Spellcheck libraries
    'hunspell-en'           # English spellcheck library
    'libreoffice-fresh'     # Libre office with extra features
    #pdfreader(shuffler/sam)  # PDF viewer
     #'typora'              #MD Notetaking
    # VIRTUALIZATION ------------------------------------------------------
    
    
    
    
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
