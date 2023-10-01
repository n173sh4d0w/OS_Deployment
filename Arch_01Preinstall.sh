#!/usr/bin/env bash
set -e

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
