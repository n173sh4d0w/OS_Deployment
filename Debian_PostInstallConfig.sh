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

sudo apt-get install -y xdg-user-dirs xorg fzf qtile lightdm rsync neofetch  # X server(for GUI)/filemgr/WM&displaymgr/archivemgrs
sudo apt-get install -y build-essential cmake dkms linux-headers-$(uname -r)   # DEVELOPMENT TOOLS
sudo apt-get install -y p7zip p7zip-full unrar-free unzip tar   # FILE ARCHIVERS
sudo apt-get install -y htop wget locate ufw              # UTILITIES
sudo apt-get install -y feh                                 # Photo
sudo apt-get install -y vim                                 # TEXT EDITORS
sudo apt-get install -y git                                 # VCS
sudo apt-get install -y gdisk                               # PARTITION TOOL
sudo apt-get install -y pdftk                               # PDF MANIPULATION
sudo apt-get install -y ffmpeg                              # VIDEO MANIPULATION
sudo apt-get install -y wavemon                             # WIRELESS DEVICE MONITORING
sudo apt-get install -y default-jre                         # JAVA RUNTIME ENVIRONMENT
sudo apt-get install -y debian-keyring  mousepad 
sudo apt-get install -y ttf-bitstream-vera  ttf-freefont ttf-mscorefont fonts-noto-mono fonts-droid-fallback fonts-freefont-ttf  fonts-opensymbol hunspell aspell  # icons/fonts(normal, bold, italic) 
sudo apt-get install -y ranger
sudo apt-get install -y openssh openssl                     # openssh server
sudo apt-get install -y bluez blueman                       # Bluetooth
sudo apt-get install -y alsa-utils pulseaudio               #soundcard
sudo apt-get install -y a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins #audio codecs
# sudo apt-get install -y default-jdk                       # JAVA DEVELOPMENT KIT (optional)
# sudo apt-get install -y tesseract-ocr tesseract-ocr-eng   # OCR (optional)


# 3. GUI SOFTWARE

sudo apt-get install -y gparted                              # PARTITION TOOL
sudo apt-get install -y network-manager-openvpn              # NETWORK MANAGER AND OPENVPN
sudo apt-get install -y pavucontrol                          # VOLUME CONTROL
sudo apt-get install -y gimp                                 # GRAPHICS EDITORS( inkscape blender)   
sudo apt-get install -y libreoffice-calc libreoffice-writer    # OFFICE (optional, not last version)
sudo apt-get install -y lxappearance                        #GTK theme switcher
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