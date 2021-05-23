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
    printf "Installing Nvidia GPU Driver...\n"
    sudo apt install -y linux-headers-$(uname -r)
    sudo apt install -y nvidia-384
fi

printf "Setting up configuration files...\n"

if [[ $NVIDIA_GA == 1 ]]; then
    sudo cp -fv ./xorg.conf /etc/X11/
    cp -fv ./monitors.xml ~/.config/
    sudo cp -fv ./monitors.xml /var/lib/lightdm/.config/
fi

cp -fv ./beets.yaml ~/.config/beets/config.yaml
cp -fv ./.aliasrc ~/


