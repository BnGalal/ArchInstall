#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

git clone https://aur.archlinux.org/pikaur.git
cd pikaur/
makepkg -si --noconfirm

sudo pacman -S --noconfirm sddm plasma kde-applications firefox obs-studio vlc papirus-icon-theme kdenlive materia-kde

sudo systemctl enable sddm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
