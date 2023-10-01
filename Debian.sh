#!/usr/bin/env bash
set -e

# Function for each phase
phase() {
    echo "$1 phase"
    case "$1" in
        "Pre-installation")
            # Update package lists and upgrade existing packages
            echo "Updating package lists and upgrading existing packages..."
            apt-get update
            apt-get upgrade -y

            # Install required tools
            echo "Installing required tools..."
            apt-get install -y gdisk curl

            # Disk partitioning and formatting
            echo "Select your disk to format (example /dev/sda):"
            lsblk
            read -r DISK
            echo -e "\nFormatting disk..."
            parted "$DISK" mklabel gpt
            parted "$DISK" mkpart primary ext4 0% 100%
            parted "$DISK" set 1 boot on
            mkfs.ext4 "${DISK}1"

            # Mount target
            echo -e "\nMounting target..."
            mount "${DISK}1" /mnt

            # Debian installation
            echo "Debian installation..."
            debootstrap stable /mnt

            # Mount necessary filesystems
            mount --bind /dev /mnt/dev
            mount --bind /proc /mnt/proc
            mount --bind /sys /mnt/sys

            echo "Chrooting into the new system..."
            chroot /mnt /bin/bash

            # System configuration (inside chroot)
            echo "Configuring the system..."

            # Set hostname
            echo "debian" > /etc/hostname

            # Set timezone
            ln -sf /usr/share/zoneinfo/Your/Timezone /etc/localtime

            # Set locales
            echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
            locale-gen

            # Configure network (replace eth0 with your network interface)
            echo "auto eth0" >> /etc/network/interfaces
            echo "iface eth0 inet dhcp" >> /etc/network/interfaces

            # Install and configure GRUB bootloader
            apt-get install -y grub-pc
            grub-install "$DISK"
            update-grub

            # Set root password
            passwd

            # Exit chroot
            exit

            # Unmount filesystems
            umount -l /mnt/dev
            umount -l /mnt/proc
            umount -l /mnt/sys
            umount -l /mnt

            echo "Rebooting the system..."
            reboot
            ;;

        "Post-installation" | "Post-configuration")
            set -ex
            
            # Update and upgrade the system
            sudo apt-get update
            sudo apt-get upgrade -y
            sudo apt-get dist-upgrade -y
            sudo apt-get autoremove -y
            
            # Define the list of CLI and GUI applications
            aptApps=(
                xdg-user-dirs xorg qtile lightdm neofetch build-essential cmake dkms linux-headers-$(uname -r) 
                p7zip p7zip-full unrar-free unzip tar htop wget curl ufw fzf rsync feh vim ranger git gdisk ffmpeg
                wavemon default-jre debian-keyring mousepad ttf-bitstream-vera ttf-freefont ttf-mscorefont
                fonts-noto-mono fonts-droid-fallback fonts-freefont-ttf fonts-opensymbol hunspell aspell openssh openssl
                bluez blueman alsa-utils pulseaudio a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2
                libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins rxvt-unicode net-tools network-manager-openvpn
                pavucontrol gimp libreoffice-calc libreoffice-writer lxappearance flameshot typora evince
            )
            
            # Install CLI and GUI applications
            sudo apt-get install -y "${aptApps[@]}"
            
            # Add Nala repository and install Nala package manager
            echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
            wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
            sudo apt update && sudo apt install nala && sudo nala fetch
            
            # Disable GRUB menu delay
            echo "GRUB_TIMEOUT_STYLE=hidden" | sudo tee -a /etc/default/grub
            sudo update-grub
            
            # Update sources.list from 'stretch' to 'buster'
            sudo sed -i 's/stretch/buster/g' /etc/apt/sources.list
            
            # Grant standard user sudo privileges
            user=$(getent passwd 1000 | awk -F: '{ print $1}')
            echo "$user ALL=(ALL:ALL) ALL" | sudo tee -a /etc/sudoers
            
            # Enable non-free repositories
            sudo sed -e '/Binary/s/^/#/g' -i /etc/apt/sources.list
            sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
            
            # Install additional themes and icons
            sudo apt-get install -y numix-gtk-theme blackbird-gtk-theme gtk2-engines-murrine gtk2-engines-pixbuf
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
            
            # Install Microsoft fonts
            sudo apt-get install -y ttf-mscorefonts-installer
            sudo mkdir /usr/share/fonts
            wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip
            wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip
            unzip *.zip && sudo mv *.ttf /usr/share/fonts
            cd .. && rm *.zip
            fc-cache -f -v
            
            # Update and clean up the system
            sudo apt-get update
            sudo apt-get upgrade -y
            sudo apt-get dist-upgrade -y
            sudo apt-get autopurge -y
            sudo apt-get autoremove -y
            sudo apt-get autoclean -y
            sudo journalctl --rotate
            sudo journalctl --vacuum-time=1s
            sudo reboot

            ;;

    esac
}

# Menu options
PS3="Select phase to operate: "
options=("Pre-installation" "Post-installation" "Post-configuration" "Quit")

select phase in "${options[@]}"; do
    [[ "$phase" == "Quit" ]] && break
    phase "$phase"
done
