#! /bin/bash

user=phil

# Only run if user is root
if [ $EUID -ne 0]; then
	echo "This script must be run as root" 1>&2
	exit 87 # exit code for non-root
fi

startdir=$(pwd)

# pacman -Syu --noconfirm archiso
pacman -Syu archiso --noconfirm

# copy releng profile to new location for customization
rm -rf ${startdir}/archlive
cp -r /usr/share/archiso/configs/releng ${startdir}/archlive

echo "neovim" >> ${startdir}/archlive/packages.x86_64

# add scripts
mkdir -p ${startdir}/archlive/airootfs/etc/skel
cp ${startdir}/inISO.sh ${startdir}/archlive/airootfs/etc/skel/
cp ${startdir}/inChroot.sh ${startdir}/archlive/airootfs/etc/skel/

cd ${startdir}/archlive && ./build.sh -v
if [[ $? != 0 ]]; then
	echo -e "\nBuild failed\n"
	exit 1
fi
cp ${startdir}/archlive/out/archlinux*.iso /home/${user}/downloads/iso/arch.iso
chown ${user} /home/${user}/downloads/iso/arch.iso
chgrp ${user} /home/${user}/downloads/iso/arch.iso
echo "coppied iso to /home/${user}/downloads/iso/arch.iso"
cp ${startdir}/vmarch /home/${user}/bin/.
cp ${startdir}/ISO_vmarch /home/${user}/bin/.

# make a folder for the vm
rm -rf /home/${user}/vm/arch
runuser -l ${user} -c 'mkdir ${HOME}/vm/arch'
cd /home/${user}/vm/arch
runuser -l ${user} -c 'qemu-img create -f raw ${HOME}/vm/arch/disk0.img 20G'
