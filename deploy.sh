#!/bin/bash

printf 'Adding user to the sudoers list... \n'
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-sudo-password

sudo apt install -y linux-headers-$(uname -r)
sudo apt install -y nvidia-384

printf 'Setting up configuration files...\n'

sudo cp -fv ./xorg.conf /etc/X11/
cp -fv ./monitors.xml ~/.config/
sudo cp -fv ./monitors.xml /var/lib/lightdm/.config/

cp -fv ./beets.yaml ~/.config/beets/config.yaml
cp -fv ./.aliasrc ~/

sudo apt install -y mc pv p7zip git wget software-properties-common apt-transport-https

sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:atareao/telegram

sudo apt update
sudo apt install -y keepassxc telegram qbittorrent firefox simple-scan qbittorrent

killall firefox

if [[ $(grep '\[Profile[^0]\]' ~/.mozilla/firefox/profiles.ini) ]]
    then PROFPATH=$(grep -E '^\[Profile|^Path|^Default' profiles.ini | grep -1 '^Default=1' | grep '^Path' | cut -c6-)
    else PROFPATH=$(grep 'Path=' ~/.mozilla/firefox/profiles.ini | sed 's/^Path=//')
fi

rm -rf ~/.mozilla/firefox/$PROFPATH/{*,.[^.]*}
cp -fv ./firefox_prefs.js ~/.mozilla/firefox/$PROFPATH/prefs.js


wget -O ~/.mozilla/firefox/$PROFPATH/extensions/ "https://addons.mozilla.org/firefox/downloads/file/3768975/ublock_origin-1.35.2-an+fx.xpi"
wget -O ~/.mozilla/firefox/$PROFPATH/extensions/ "https://addons.mozilla.org/firefox/downloads/file/3760520/https_everywhere-2021.4.15-an+fx.xpi"
wget -O ~/.mozilla/firefox/$PROFPATH/extensions/ "https://addons.mozilla.org/firefox/downloads/file/3719726/privacy_badger-2021.2.2-an+fx.xpi"
wget -O ~/.mozilla/firefox/$PROFPATH/extensions/ "https://addons.mozilla.org/firefox/downloads/file/3748919/clearurls-1.21.0-an+fx.xpi"
wget -O ~/.mozilla/firefox/$PROFPATH/extensions/ "https://addons.mozilla.org/firefox/downloads/file/3780797/sponsorblock_skip_sponsorships_on_youtube-2.0.16.2-an+fx.xpi"

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

sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

cp -fv ./.zshrc ~/
cp -fv ./prototerm.zsh-theme ~/.oh-my-zsh/themes/

sudo bash ./build-kernel.sh
