#! /bin/bash

echo -e "\n\nConfigure time zone"
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

echo -e "\n\nGenerate locale"
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo -e "\n\nSet hostname"
echo zarch > /etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost" >> /etc/hosts

echo -e "\n\nInstall packages"
pacman -Syu --noconfirm neovim sudo dhcpcd grub 

echo -e "\n\nSet up networking"
systemctl enable dhcpcd@ens3.service

echo -e "\n\nSet up grub"
grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\n\nSet root password"
passwd
