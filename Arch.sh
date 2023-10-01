#!/usr/bin/env bash
set -e

# Function for each phase
phase() {
    echo "$1 phase"
    case "$1" in
        "Pre-installation")
            # Set up mirrors for optimal download - US Only
            echo "Setting up mirrors for optimal download - US Only"
            timedatectl set-ntp true
            pacman-key --init
            pacman-key --populate
            pacman -Sy --noconfirm
            pacman -S --noconfirm pacman-contrib
            mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
            curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on" | sed -e '/^#Server/s/^#//' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

            # Install prerequisites
            echo -e "\nInstalling prerequisites..."
            pacman -S --noconfirm gptfdisk

            # Select and format the disk
            echo "Select your disk to format (example /dev/sda):"
            lsblk
            read -r DISK
            echo -e "\nFormatting disk..."
            sgdisk -Z "$DISK" # zap all on disk
            sgdisk -a 2048 -o "$DISK" # new gpt disk 2048 alignment

            # Create partitions
            sgdisk -n 1:0:+1000M "$DISK" # partition 1 (UEFI SYS), default start block, 512MB
            sgdisk -n 2:0:0 "$DISK" # partition 2 (Root), default start, remaining

            # Set partition types
            sgdisk -t 1:ef00 "$DISK"
            sgdisk -t 2:8300 "$DISK"

            # Label partitions
            sgdisk -c 1:"UEFISYS" "$DISK"
            sgdisk -c 2:"ROOT" "$DISK"

            # Make filesystems
            echo -e "\nCreating Filesystems..."
            mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
            mkfs.ext4 -L "ROOT" "${DISK}2"

            # Mount target
            mkdir -p /mnt/boot/efi
            mount -t ext4 "${DISK}2" /mnt
            mkdir -p /mnt/boot
            mount -t vfat "${DISK}1" /mnt/boot/

            # Arch Install on Main Drive
            echo "Arch Install on Main Drive"
            pacstrap /mnt base base-devel linux linux-firmware networkmanager --noconfirm --needed

            # Setup Dependencies
            echo "Setup Dependencies"
            genfstab -U /mnt >> /mnt/etc/fstab

            # Bootloader Systemd Installation
            echo "Bootloader Systemd Installation"
            bootctl install --esp-path /mnt/boot
            cat <<EOF > /mnt/boot/loader/entries/arch.conf
            title Arch Linux
            linux /vmlinuz-linux
            initrd /initramfs-linux.img
            options root=${DISK}p2 rw
            EOF

            arch-chroot /mnt

            # SYSTEM READY FOR FIRST BOOT
            echo "SYSTEM READY FOR FIRST BOOT"
            ;;
            
        "Post-installation")
            PKGS=(
                'xorg-server' 'xorg-apps' 'xorg-xinit' 'xf86-video-intel' 'xserver-xorg-input-synaptics' 'xf86-input-synaptics'
                'qtile'
                'wpa_supplicant' 'dialog' 'networkmanager' 'openvpn' 'networkmanager-openvpn' 'networkmanager-vpnc' 'network-manager-applet' 'dhclient' 'libsecret'
                'bluez' 'bluez-utils' 'bluez-firmware' 'blueberry' 'pulseaudio-bluetooth' 'bluez-libs'
                'alsa-utils' 'alsa-plugins' 'alsa-firmware' 'pulseaudio' 'pulseaudio-alsa' 'pavucontrol'
                'cups' 'cups-pdf' 'ghostscript' 'gsfonts' 'hplip' 'system-config-printer'
                'linux-lts' 'linux-lts-headers' 'lxappearance'
                'bash-completion' 'curl' 'wget' 'feh' 'keepass2' 'ufw' 'fail2ban' 'hardinfo' 'htop' 'inxi' 'jq' 'jshon' 'neofetch' 'ntp' 'numlockx' 'screenkey' 'openssh' 'rsync' 'speedtest-cli' 'terminus-font' 'tlp' 'unrar-free' 'unzip' 'p7zip-plugins' 'p7zip' 'p7zip-full' 'tar' 'alacritty' 'zenity'
                'autofs' 'exfat-utils' 'gparted' 'gnome-disks' 'ntfs-3g' 'parted'
                'fzf' 'ranger' 'veracrypt'
                'vim' 'cmake' 'git' 'gcc' 'glibc' 'php' 'python'
                'ffmpeg' 'flameshot'
                'gimp'
                'hunspell' 'hunspell-en' 'libreoffice-fresh' 'evince'
            )

            for PKG in "${PKGS[@]}"; do
                echo "INSTALLING: $PKG"
                sudo pacman -S --noconfirm --needed "$PKG"
            done

            echo "Done!"

            echo "INSTALLING YAY_pkgmgr"
            echo

            mkdir -p "$HOME/GitRepos" && cd "$HOME/GitRepos"

            echo "CLONING: YAY"
            git clone "https://aur.archlinux.org/yay.git"

            PKGS_YAY=(
                'gtkhash'
                'keepass2'
                'slimlock'
                'oomox'
                'peek'
                'gtk-theme-arc-git'
                'adapta-gtk-theme-git'
                'paper-icon-theme'
                'tango-icon-theme'
                'tango-icon-theme-extras'
                'numix-icon-theme-git'
                'sardi-icons'
            )

            cd "$HOME/GitRepos/yay"
            makepkg -si && yay -Syy

            for PKG in "${PKGS_YAY[@]}"; do
                sudo yay -S --noconfirm "$PKG"
            done

            echo "Done!"

            echo "Cleaning up unwanted packages"
            yay -Qtdq | yay -Rns --noconfirm - 2>/dev/null

            echo "REBOOT TO USE THE NEW CONFIG"
            read -rp "Would you like to reboot? (y/N) " reboot
            [[ "${reboot,,}" == "y" ]] && sudo reboot
            ;;
            
        "Post-configuration")
            # Generate .xinitrc file
            cat <<EOF > "${HOME}/.xinitrc"
            #!/bin/bash

            if [ -d /etc/X11/xinit/xinitrc.d ]; then
                for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
                    [ -x "\$f" ] && . "\$f"
                done
                unset f
            fi

            xset -b # Disable bell
            xset -dpms # Disable Power Saving
            xset s off # Disable screensaver
            xsetroot -solid darkgrey # X Root window color
            setxkbmap -layout us -option ctrl:nocaps # Caps to Ctrl
            if [ -d /etc/X11/xinit/xinitrc.d ]; then
                for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
                    [ -x "\$f" ] && . "\$f"
                done
                unset f
            fi

            source /etc/xdg/xfce4/xinitrc
            exit 0
            EOF

            # Update /bin/startx path
            sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

            # Configure LTS Kernel as a secondary boot option
            sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
            sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
            sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
            sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

            # Configure MAKEPKG to use all 8 cores
            sudo sed -i -e 's|[#]*MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|g' /etc/makepkg.conf
            sudo sed -i -e 's|[#]*COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T 8 -z -)|g' /etc/makepkg.conf

            # Set a larger font for login shell
            sudo cat <<EOF > /etc/vconsole.conf
            KEYMAP=us
            FONT=ter-v32b
            EOF

            # Set laptop lid close to suspend
            sudo sed -i -e 's|[# ]*HandleLidSwitch[ ]*=[ ]*.*|HandleLidSwitch=suspend|g' /etc/systemd/logind.conf

            # Disable buggy cursor inheritance
            sudo cat <<EOF > /usr/share/icons/default/index.theme
            [Icon Theme]
            EOF

            # Increase file watcher count
            echo "fs.inotify.max_user_watches=524288" | sudo tee /etc/sysctl.d/40-max-user-watches.conf > /dev/null && sudo sysctl --system

            # Disable Pulse .esd_auth module
            sudo sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

            # Enable Bluetooth and set it to auto-start
            sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
            sudo systemctl enable bluetooth.service
            sudo systemctl start bluetooth.service

            # Enable CUPS for printing
            sudo systemctl enable org.cups.cupsd.service
            sudo systemctl start org.cups.cupsd.service

            # Enable Login Display Manager
            sudo systemctl enable lightdm.service
            sudo systemctl start lightdm.service

            # Enable Cronie
            sudo touch /etc/crontab
            sudo systemctl enable cronie.service
            sudo systemctl start cronie.service

            # Enable Network Time Protocol
            sudo ntpd -qg
            sudo systemctl enable ntpd.service
            sudo systemctl start ntpd.service

            # Network Setup
            echo "Find your IP Link name:"
            ip link
            read -p "ENTER YOUR IP LINK: " LINK
            echo "Disabling DHCP and enabling Network Manager daemon"
            sudo systemctl disable dhcpcd.service
            sudo systemctl stop dhcpcd.service
            sudo ip link set dev "${LINK}" down
            sudo systemctl enable NetworkManager.service
            sudo systemctl start NetworkManager.service
            sudo ip link set dev "${LINK}" up

            # Secure Linux
            echo "Setup UFW rules"
            sudo ufw limit 22/tcp
            sudo ufw allow 80/tcp
            sudo ufw allow 443/tcp
            sudo ufw default deny incoming
            sudo ufw default allow outgoing
            sudo ufw enable

            echo "Harden /etc/sysctl.conf"
            sudo sysctl kernel.modules_disabled=1
            sudo sysctl -a
            sudo sysctl -A
            sudo sysctl mib
            sudo sysctl net.ipv4.conf.all.rp_filter
            sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

            echo "Prevent IP SPOOFS"
            cat <<EOF > /etc/host.conf
            order bind,hosts
            multi on
            EOF

            echo "Enable fail2ban"
            sudo cp jail.local /etc/fail2ban/
            sudo systemctl enable fail2ban
            sudo systemctl start fail2ban

            echo "Listening ports"
            sudo netstat -tunlp

            # Clean
            sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
            sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

            if [[ ! -n $(pacman -Qdt) ]]; then
                echo "No orphaned packages to remove."
            else
                sudo pacman -Rns $(pacman -Qdtq)
            fi

            echo "Done!"
            echo
            echo "Reboot now..."
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
