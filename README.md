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
# sudo makeISO.sh
```
