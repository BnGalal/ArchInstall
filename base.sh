#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Baghdad /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# pacman -S  virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak

pacman -S --noconfirm xorg networkmanager network-manager-applet dialog ntfs-3g wireless_tools wpa_supplicant os-prober mtools dosfstools git base-devel linux-headers xf86-video-intel bluez bluez-utils cups alsa-utils pulseaudio pulseaudio-bluetooth grub efibootmgr xdg-utils openssh hplip

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-install --target=i386-pc /dev/sdX # replace sdx with your disk name, not the partition
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
#systemctl enable sshd
#systemctl enable fstrim.timer

useradd -m xxxuser
echo xxxuser:password | chpasswd
usermod -aG libvirt xxxuser

echo "xxxuser ALL=(ALL) ALL" >> /etc/sudoers.d/xxxuser


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
