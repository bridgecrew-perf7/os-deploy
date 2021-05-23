#!/bin/bash

printf 'Adding user to the sudoers list... \n'
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-sudo-password

gpu=$(lspci | grep -i '.* vga .* nvidia .*')
shopt -s nocasematch

if [[ $gpu == *' nvidia '* ]]; then
  printf 'Nvidia GPU is present:  %s\n' "$gpu"
  NVIDIA_GA=1
else
  printf 'Nvidia GPU is not present: %s\n' "$gpu"
  NVIDIA_GA=0
fi

if [[ $NVIDIA_GA == 1 ]]; then
    printf 'Installing Nvidia GPU Driver...\n'
    sudo apt install -y linux-headers-$(uname -r)
    sudo apt install -y nvidia-384
fi

printf 'Setting up configuration files...\n'

if [[ $NVIDIA_GA == 1 ]]; then
    sudo cp -fv ./xorg.conf /etc/X11/
    cp -fv ./monitors.xml ~/.config/
    sudo cp -fv ./monitors.xml /var/lib/lightdm/.config/
fi

cp -fv ./beets.yaml ~/.config/beets/config.yaml
cp -fv ./.aliasrc ~/

sudo apt install -y zsh git wget software-properties-common apt-transport-https
#sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:atareao/telegram

sudo apt update
sudo apt install -y keepassxc telegram qbittorrent firefox simple-scan qbittorrent

wget "https://ftp.hp.com/pub/softlib/software13/printers/SS/SL-C4010ND/uld_V1.00.39_01.17.tar.gz" -O /tmp/uld_V1.00.39_01.17.tar.gz
tar -xvf /tmp/uld_V1.00.39_01.17.tar.gz -C /tmp/
sudo bash /tmp/uld/install-printer.sh

wget http://security.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.2_amd64.deb -O /tmp/multiarch-support_2.27-3ubuntu1.2_amd64.deb
sudo dpkg -i /tmp/multiarch-support_2.27-3ubuntu1.2_amd64.deb
wget https://mirrors.edge.kernel.org/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb -O /tmp/libgnome-keyring-common_3.12.0-1build1_all.deb
sudo dpkg -i /tmp/libgnome-keyring-common_3.12.0-1build1_all.deb
wget https://ftp.osuosl.org/pub/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb -O /tmp/libgnome-keyring0_3.12.0-1build1_amd64.deb
sudo dpkg -i /tmp/libgnome-keyring0_3.12.0-1build1_amd64.deb
sudo apt install -y libappindicator1 gconf2
wget https://desktop.userapi.com/debian/pool/master/v/vk/vk_5.2.3-1_amd64.deb -O /tmp/vk_5.2.3-1_amd64.deb
sudo dpkg -i /tmp/vk_5.2.3-1_amd64.deb

sudo apt install -y libc++1 libc++1-10 libc++abi1-10
wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i /tmp/discord.deb
