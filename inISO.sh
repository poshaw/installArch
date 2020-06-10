#! /bin/bash

echo -e "\n\nUpdate mirrorlist"
# nvim /etc/pacman.d/mirrorlist
# :7,$ g/## \(United States\)\@!/,+1d_
# :wq
nvim -c "7,$ g/## \(United States\)\@\!/,+1d" -c "wq" /etc/pacman.d/mirrorlist
pacman -Syu --noconfirm

# setup time zonels
echo -e "\n\nSetting up timezone"
timedatectl set-timezone America/Chicago

# set up partitions
echo -e "\n\nSetting up partitions"
sgdisk --zap-all /dev/vda
parted -s /dev/vda mklabel msdos
parted -s /dev/vda mkpart primary 1MiB 513MiB
parted -s /dev/vda mkpart primary 514MiB 100%
parted -s /dev/vda set 1 boot on
mkfs.vfat /dev/vda1
mkfs.ext4 /dev/vda2
lsblk

# Mount partitions
echo -e "\n\nMount partitions"
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
