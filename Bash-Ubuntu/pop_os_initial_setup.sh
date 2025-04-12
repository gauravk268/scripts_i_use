#!/bin/bash

# Customize terminal
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# install apt-fast for parallel download
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt-get -y install apt-fast


# Installs all required software

# Update packages
sudo apt-fast update
sudo apt-fast upgrade -y
flatpak update -y


# Install APT packages
sudo apt-fast install -y \
build-essential \
chrome-gnome-shell \
fcitx fcitx-googlepinyin \
gdebi git gnome-tweaks gparted \
neofetch nethogs net-tools \
synaptic \
timeshift tlp tlp-rdw \
ubuntu-restricted-extras \
variety virtualbox vlc vnstat


sudo ufw enable


# Change fcitx UI
sudo apt remove fcitx-ui-classic -y
sudo apt-fast install fcitx-ui-qimpanel -y


# Install Appimagelauncher
sudo add-apt-repository ppa:appimagelauncher-team/stable -y
sudo apt-fast install appimagelauncher -y


# Install tlp UI
sudo add-apt-repository ppa:linuxuprising/apps -y
sudo apt-fast install tlpui -y


# Start tlp
sudo tlp start
sudo systemct1 enable tlp


# Install Google Chrome
wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_135.0.3179.73-1_amd64.deb
sudo apt install ./microsoft-edge-stable_135.0.3179.73-1_amd64.deb -y
rm microsoft-edge-stable_135.0.3179.73-1_amd64.deb


# Install Miniconda for python
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo bash -c ./Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

bash -c "$(curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh)"


# Install Nerd Fonts
git clone https://github.com/ryanoasis/nerd-fonts.git
sudo ./nerd-fonts/install.sh


# Install Flatpaks
flatpak install -y \
com.getpostman.Postman \
com.github.gijsgoudzwaard.image-optimizer \
nl.hjdskes.gcolor3 


# install node version manager
bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)"


# update system settings
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 0


# cleanup
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean

# Reboot
sudo reboot

