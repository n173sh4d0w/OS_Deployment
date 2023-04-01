###############################################################
# INSTALL ADDITIONAL CLI&GUI SOFTWARE ON DEBIAN #
###############################################################

# | THIS SCRIPT IS TESTED CORRECTLY ON |
# |------------------------------------|
# | OS             | Test | Last test  |
# |----------------|------|------------|
# | Debian 11.3    | OK   | 9 Jul 2022 |

# 1. KEEP DEBIAN UP TO DATE

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove


# 2. CLI SOFTWARE

sudo apt-get install -y xdg-user-dirs xorg  qtile lightdm neofetch # X server(for GUI)/filemgr/WM&displaymgr/archivemgrs
sudo apt-get install -y build-essential cmake dkms linux-headers-$(uname -r)   # DEVELOPMENT TOOLS
sudo apt-get install -y p7zip p7zip-full unrar-free unzip tar   # FILE ARCHIVERS
sudo apt-get install -y htop wget curl ufw fzf rsync        # UTILITIES
sudo apt-get install -y feh                                 # Photo
sudo apt-get install -y vim                                 # TEXT EDITORS
sudo apt-get install -y git                                 # VCS
sudo apt-get install -y gdisk                               # PARTITION TOOL
sudo apt-get install -y ffmpeg                              # VIDEO MANIPULATION
sudo apt-get install -y wavemon                             # WIRELESS DEVICE MONITORING
sudo apt-get install -y default-jre                         # JAVA RUNTIME ENVIRONMENT
sudo apt-get install -y debian-keyring  mousepad 
sudo apt-get install -y ttf-bitstream-vera  ttf-freefont ttf-mscorefont fonts-noto-mono fonts-droid-fallback fonts-freefont-ttf  fonts-opensymbol hunspell aspell  # icons/fonts(normal, bold, italic) 
sudo apt-get install -y ranger                              #CLI filemgr
sudo apt-get install -y openssh openssl                     # openssh server
sudo apt-get install -y bluez blueman                       # Bluetooth
sudo apt-get install -y alsa-utils pulseaudio               #soundcard
sudo apt-get install -y a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins #audio codecs
sudo apt-get install -y rxvt-unicode
sudo apt-get install -y  net-tools network-manage
# sudo apt-get install -y default-jdk                       # JAVA DEVELOPMENT KIT (optional)
# sudo apt-get install -y tesseract-ocr tesseract-ocr-eng   # OCR (optional)
#sudo apt-get install -y pdf                                # PDF MANIPULATION

# 3. GUI SOFTWARE

sudo apt-get install -y gparted                              # PARTITION TOOL
sudo apt-get install -y network-manager-openvpn              # NETWORK MANAGER AND OPENVPN
sudo apt-get install -y pavucontrol                          # VOLUME CONTROL
sudo apt-get install -y gimp                                 # GRAPHICS EDITORS( inkscape blender)   
sudo apt-get install -y libreoffice-calc libreoffice-writer  # OFFICE (optional, not last version)
sudo apt-get install -y lxappearance                         #GTK theme switcher
sudo apt-get install -y flameshot typora pdfsam evince 
#sudo apt-get install -y geany                               # TEXT EDITOR
#sudo apt-get install -y filezilla                           # FTP/FTPS/SFTP CLIENT
#sudo apt-get install -y kazam                               # SCREENCAST
#sudo apt-get install -y gvfs-backends                       # USERSPACE VIRTUAL FILESYSTEM
#sudo apt-get install -y xarchiver                           # FILE ARCHIVER FRONTEND
#sudo apt-get install -y network-manager-openvpn-gnome       # NETWORK MANAGER AND OPENVPN FOR GNOME
#sudo apt-get install -y transmission-gtk                    # BITTORRENT CLIENT
#sudo apt-get install -y galculator                          # SCIENTIFIC CALCULATOR
#sudo apt-get install -y mpv                                 # VIDEO AND AUDIO PLAYER
# sudo apt-get install -y texlive-full texmaker             # LATEX (optional, heavy package)
# sudo apt-get install -y imagemagick                       # IMAGE MANIPULATION PROGRAM (optional)

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

# make an ubuntu font folder
sudo mkdir /usr/share/fonts

#DL fonts family&&change dirs into unzipped folder
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip  
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip  

unzip *.zip && sudo mv *.ttf /usr/share/fonts

#$HOME to remove all 
cd .. && rm *.zip  

fc-cache -f -v



sudo apt update


