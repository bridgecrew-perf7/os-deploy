#!/bin/bash

wget -O /tmp/zen-kernel.zip https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v5.12.6-zen1.zip
unzip /tmp/zen-kernel.zip -d /tmp/zen-kernel/
sudo apt install -y build-essential libncurses5-dev libelf-dev libssl-dev bison flex gcc make zstd
sudo cp -fv ./kernelcfg-5.12.6-zen1 /tmp/zen-kernel/zen-kernel-5.12.6-zen1/.config
cd /tmp/zen-kernel/zen-kernel-5.12.6-zen1
make -j$(nproc --all) bindeb-pkg
cd ..
sudo dpkg -i linux-libc-dev_5.12.6-zen1-1_amd64.deb linux-image-5.12.6-zen1_5.12.6-zen1-1_amd64.deb linux-headers-5.12.6-zen1_5.12.6-zen1-1_amd64.deb
