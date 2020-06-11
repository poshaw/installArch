# installArch
How I set up a new arch VM using qemu MBR BIOS

## Instructions:
All instructions assume you are running Arch Linux, you will need to change the pacman -Syu to apt or yum commands depending on your host distro.

## Get this repository
```shell
$ git clone git@github.com:poshaw/installArch.git
$ cd installArch/
```

## Make the Arch.iso
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
## Launch the VM
```shell
$ sudo pacman -S qemu
$ ~/bin/ISO_vmarch
```


## Install some software from suckless
install X server & git
```shell
# sudo -i
# pacman -S xorg-xinit xorg git
```

change directory to /usr/src because you want this to apply to all users
```shell
# cd /usr/src
```

clone suckless software such as dwm (window manager), st (recommended terminal), and dmenu (simple application menu)

```shell
# git clone git://git.suckless.org/dwm
# git clone git://git.suckless.org/st
# git clone git://git.suckless.org/dmenu
# git clone git://git.suckless.org/surf
```

change directory into each one, and compile them

```shell
# cd dwm
# make clean install
```
return to normal user
```shell
# exit
```
```shell
$ nvim ~/.xinitrc
```
add the following line, save & quit
```bash
exec dwm
```

start your session with:
```shell
$ startx
```
