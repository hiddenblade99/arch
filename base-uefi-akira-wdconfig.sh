#!/bin/bash

mkfs.ext4 /dev/sdb5
mount /dev/sdb5 /mnt
mkdir /mnt/boot
mount /dev/sdb4 /mnt/boot

pacstrap /mnt base linux linux-firmware vim amd-ucode

genfstab -U/mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "pangea" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 pangea.localdomain pangea" >> /etc/hosts
echo root:password | chpasswd
pacman -S --noconfirm grub efibootmgr networkmanager dialog wpa_supplicant mtools dosfstools base-devel linux-headers pulseaudio os-prober ntfs-3g firefox mpv mupdf sxiv tlp tlp-rdw telegram-desktop pavucontrol git hsetroot
pacman -S --noconfirm xf86-video-amdgpu
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB 
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable tlp 
useradd -m akira
echo akira:password | chpasswd
echo "akira ALL=(ALL) ALL" >> /etc/sudoers.d/akira
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
