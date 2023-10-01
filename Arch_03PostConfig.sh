#!/usr/bin/env bash

echo "FINAL SETUP AND CONFIGURATION"

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
