#! /bin/bash

user=phil

echo -e "\n\nConfigure time zone"
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

echo -e "\n\nGenerate locale"
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo -e "\n\nSet hostname"
echo varch > /etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost" >> /etc/hosts

echo -e "\n\nInstall packages"
pacman -Syu --noconfirm neovim sudo dhcpcd grub xorg-xinit xorg git

# use sed to uncomment wheel group from sudoers
sed 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers > /etc/sudoers.new
export EDITOR="cp /etc/sudoers.new"
visudo
rm /etc/sudoers.new

echo -e "\n\nSet up networking"
systemctl enable dhcpcd@ens3.service

echo -e "\n\nSet up grub"
grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\n\nSet root password"
passwd

echo -e "\n\nCreate user account"
useradd -m -g users -G wheel -s /bin/bash ${user}
echo "enter password for user: ${user}"
passwd ${user}

cd /usr/src
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/st
git clone git://git.suckless.org/dmenu

cd dwm && make clean install
cd ../st && make clean install
cd ../dmenu && make clean install

runuser -l ${user} -c 'echo "exec dwm" > /home/${USER}/.xinitrc'
