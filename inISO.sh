#! /bin/bash

echo -e "\n\nUpdate mirrorlist"
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
pacman -Syu --noconfirm

# setup time zonels
echo -e "\n\nSetting up timezone"
timedatectl set-timezone America/Chicago

echo -e "\n\nSetting up partitions"

sgdisk --zap-all /dev/vda
parted -s /dev/vda mklabel msdos
parted -s /dev/vda mkpart primary 1MiB 257MiB
parted -s /dev/vda mkpart primary 258MiB 100%
parted -s /dev/vda set 1 boot on
mkfs.vfat /dev/vda1
mkfs.ext4 /dev/vda2
lsblk

echo -e "\n\nMount root partition"
mount /dev/vda2 /mnt
mkdir /mnt/boot
mount --rw -t vfat /dev/vda1 /mnt/boot

echo -e "\n\nCopy scripts"
cp inChroot.sh /mnt/.

echo -e "\n\nGenerate fstab"
mkdir -p /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab

echo -e "\n\nInstall base system to /mnt"
pacstrap /mnt base base-devel linux linux-firmware neovim

echo -e "\n\nChroot into new system"
arch-chroot /mnt
