# installArch
How I set up a new arch VM using qemu MBR BIOS

# Instructions:
All instructions assume you are running Arch Linux, you will need to change the pacman -Syu to apt or yum commands depending on your host distro.

# Make the Arch.iso
Update user variable in first line of makeISO.sh
```bash
vi makeISO.sh
```
```bash
user=userName
```

run makeISO.sh
```bash
sudo makeISO.sh
```
