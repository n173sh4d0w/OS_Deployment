###############################################################
# INSTALL ADDITIONAL CLI&GUI SOFTWARE ON DEBIAN #
###############################################################

# | THIS SCRIPT IS TESTED CORRECTLY ON |
# |------------------------------------|
# | OS             | Test | Last test  |
# |----------------|------|------------|
# | Debian 11.3    | OK   | 9 Jul 2022 |
set -xe #1st line to check error via shellcheck
# 1. KEEP DEBIAN UPTODATE

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove


# 2. CLI&GUI Apps
aptApps=(
			xdg-user-dirs xorg  qtile lightdm neofetch # X server(for GUI)/filemgr/WM&displaymgr/archivemgrs
      build-essential cmake dkms linux-headers-$(uname -r)   # DEVELOPMENT TOOLS
      p7zip p7zip-full unrar-free unzip tar   # FILE ARCHIVERS
      htop wget curl ufw fzf rsync        # UTILITIES
      feh                                 # Photo
      vim                                 # TEXT EDITORS
      ranger                              #CLI filemgr
      git                                 # VCS
      gdisk                               # PARTITION TOOL
      ffmpeg                              # VIDEO MANIPULATION
      wavemon                             # WIRELESS DEVICE MONITORING
      default-jre                         # JAVA RUNTIME ENVIRONMENT
      debian-keyring  mousepad 
      ttf-bitstream-vera  ttf-freefont ttf-mscorefont fonts-noto-mono fonts-droid-fallback fonts-freefont-ttf  fonts-opensymbol hunspell aspell  # icons/fonts(normal, bold, italic) 
      openssh openssl                     # openssh server
      bluez blueman                       # Bluetooth
      alsa-utils pulseaudio               #soundcard
      a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins #audio codecs
      rxvt-unicode                        #term
      net-tools network-manage
      # default-jdk                       # JAVA DEVELOPMENT KIT (optional)
      # tesseract-ocr tesseract-ocr-eng   # OCR (optional)
      # pdf                                # PDF MANIPULATION
#####GUI
      gparted                              # PARTITION TOOL
      network-manager-openvpn              # NETWORK MANAGER AND OPENVPN
      pavucontrol                          # VOLUME CONTROL
      gimp                                 # GRAPHICS EDITORS( inkscape blender)   
      libreoffice-calc libreoffice-writer  # OFFICE (optional, not last version)
      lxappearance                         #GTK theme switcher
      flameshot typora evince 
      #filezilla                           # FTP/FTPS/SFTP CLIENT
      #kazam                               # SCREENCAST
      #gvfs-backends                       # USERSPACE VIRTUAL FILESYSTEM
      #xarchiver                           # FILE ARCHIVER FRONTEND
      #network-manager-openvpn-gnome       # NETWORK MANAGER AND OPENVPN FOR GNOME
      #transmission-gtk                    # BITTORRENT CLIENT
      #galculator                          # SCIENTIFIC CALCULATOR
      #mpv                                 # VIDEO AND AUDIO PLAYER
      #texlive-full texmaker             # LATEX (optional, heavy package)
      #imagemagick                       # IMAGE MANIPULATION PROGRAM (optional)
			)
pipDepends=(  
           
           )
sudo apt-get install -y "${aptCLIs[@]}" && sudo pip3 install -y "${pipDepends[@]}"  #-y  suppress the prompt

# 4. Nala PKGMGR(apt, slower)
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install nala && sudo nala fetch #Select 3 mirrors

# 5. GRUB,Disable GRUB menu delay-5s, to spead up boot process(holding ESC during boot to call GRUB menu)
echo "set GRUB_TIMEOUT_STYLE=hidden" >> ~/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg 

# stretch-to-buster
sudo sed -i 's/stretch/buster/gI' /etc/apt/sources.list

# run-as-root-grant-standard-user-sudo
apt install sudo -yy
user=$(getent passwd 1000 |  awk -F: '{ print $1}') #  Find the standard user created during installation&make it a variable
echo "$user  ALL=(ALL:ALL)  ALL" >> /etc/sudoers   # Echo the user into the sudoers file

#run-as-root-non-free-repos
sudo sed -e '/Binary/s/^/#/g' -i /etc/apt/sources.list
sudo sed -i 's/main/main contrib non-free/gI' /etc/apt/sources.list


#######Themes&Icons
sudo apt install -yy numix-gtk-theme blackbird-gtk-theme gtk2-engines-murrine gtk2-engines-pixbuf

# Install Papirus Icons
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
cd papirus-icon-theme/
./install.sh
cd ..
sudo rm -r papirus*

git clone https://github.com/vinceliuice/vimix-gtk-themes
cd vimix-gtk-themes
./Install
cd ..
sudo rm -r vimix*

#########Fonts
sudo apt install ttf-mscorefonts-installer #microsoft fonts
#Create font folder
sudo mkdir /usr/share/fonts
#DL fonts family&&change dirs into unzipped folder
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip  
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip  
unzip *.zip && sudo mv *.ttf /usr/share/fonts
#$HOME to remove all 
cd .. && rm *.zip  

fc-cache -f -v



sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autopurge && sudo apt autoremove && sudo apt autoclean && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo reboot


