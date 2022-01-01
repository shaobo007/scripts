#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install build-essential cmake curl git neofetch proxychains fcitx fish openssh-server net-tools feh flameshot vlc figlet 
sudo apt install libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev sharutils
sudo chsh -s /usr/bin/fish 
echo "socks 127.0.0.1 7891" >> /etc/proxychains.conf
echo "http  127.0.0.1 7890" >> /etc/proxychains.conf

