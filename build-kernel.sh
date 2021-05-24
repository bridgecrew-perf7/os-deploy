#!/bin/bash

wget -O /tmp/zen-kernel.zip https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v5.12.6-zen1.zip
unzip /tmp/zen-kernel.zip -d /tmp/zen-kernel/
sudo apt install -y build-essential libncurses5-dev libelf-dev libssl-dev bison flex gcc make
sudo cp -fv ./kernelcfg-5.12.6-zen1 /tmp/zen-kernel/.config
cd /tmp/zen-kernel/
make -j4 bindeb-pkg
