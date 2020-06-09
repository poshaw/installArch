# installArch
How I set up a new arch VM using qemu MBR BIOS

# Instructions:
All instructions assume you are running Arch Linux, you will need to change the pacman -Syu to apt or yum commands depending on your host distro.

# Get this repository
```shell
$ git clone git@github.com:poshaw/installArch.git
$ cd installArch/
```

# Make the Arch.iso
Update user variable in first line of makeISO.sh
```shell
$ vi makeISO.sh
```
```bash
user=userName
```
Type: `[Esc]:wq` to save & quit.

run makeISO.sh
```shell
$ sudo makeISO.sh
```

You should now have the following files in your home directory:
The .iso:
```shell
/home/${user}/downloads/iso/arch.iso
```
The .img:
```shell
/home/${user}/vm/arch/disk0.img
```
and the qemu virtual machine launch scripts:
```shell
/home/${user}/bin/vmarch
/home/${user}/bin/ISO_vmarch
```

