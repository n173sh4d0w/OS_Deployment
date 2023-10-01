#!/usr/bin/env bash
set -e

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
    sudo pacman -S "$PKG" --noconfirm --needed
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
    sudo yay -S "$PKG" --noconfirm
done

echo "Done!"

echo "Cleaning up unwanted packages"
yay -Qtdq | yay -Rns --noconfirm - 2>/dev/null

echo "REBOOT TO USE THE NEW CONFIG"
read -rp "Would you like to reboot? (y/N) " reboot
[[ "${reboot,,}" == "y" ]] && sudo reboot
