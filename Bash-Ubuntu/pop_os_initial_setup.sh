#!/bin/bash

# Exit on error, unset variable, and pipeline failure
set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
status() {
    echo -e "${GREEN}[*]${NC} $1"
}

# Function to print warnings
warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Function to print errors and exit
error() {
    echo -e "${RED}[X]${NC} $1" >&2
    exit 1
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    warning "It's not recommended to run this script as root. Some operations may not work correctly."
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Install Oh My Bash if not already installed
if [[ ! -d "$HOME/.oh-my-bash" ]]; then
    status "Installing Oh My Bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || warning "Oh My Bash installation failed"
else
    status "Oh My Bash already installed"
fi

# Configure apt-fast for parallel downloads
status "Setting up apt-fast..."
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt-get update
sudo apt-get install -y apt-fast || error "Failed to install apt-fast"

# System update
status "Updating system packages..."
sudo apt-fast update && sudo apt-fast upgrade -y
flatpak update -y || warning "Flatpak update failed"

# Install essential packages
status "Installing APT packages..."
sudo apt-fast install -y \
    build-essential \
    chrome-gnome-shell \
    fcitx fcitx-googlepinyin \
    gdebi git gnome-tweaks gparted \
    neofetch nethogs net-tools \
    synaptic \
    timeshift tlp tlp-rdw \
    ubuntu-restricted-extras \
    variety virtualbox vlc vnstat || warning "Some packages failed to install"

# Enable firewall
status "Enabling UFW firewall..."
sudo ufw enable

# Fcitx UI replacement
status "Configuring Fcitx..."
sudo apt remove -y fcitx-ui-classic
sudo apt-fast install -y fcitx-ui-qimpanel || warning "Fcitx UI installation failed"

# AppImageLauncher
status "Installing AppImageLauncher..."
sudo add-apt-repository ppa:appimagelauncher-team/stable -y
sudo apt-fast install -y appimagelauncher || warning "AppImageLauncher installation failed"

# TLP UI
status "Installing TLP UI..."
sudo add-apt-repository ppa:linuxuprising/apps -y
sudo apt-fast install -y tlpui || warning "TLP UI installation failed"

# Start TLP
status "Configuring TLP..."
sudo tlp start
sudo systemctl enable tlp || warning "Failed to enable TLP"

# Install Microsoft Edge (not Google Chrome as comment suggests)
status "Installing Microsoft Edge..."
edge_deb="microsoft-edge-stable.deb"
wget -q "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_135.0.3179.73-1_amd64.deb" -O "$edge_deb"
sudo apt install -y "./$edge_deb" || warning "Microsoft Edge installation failed"
rm -f "$edge_deb"

# Install Miniconda (removed duplicate installation)
status "Installing Miniconda..."
miniconda_script="Miniconda3-latest-Linux-x86_64.sh"
wget -q "https://repo.anaconda.com/miniconda/$miniconda_script"
bash "$miniconda_script" -b -p "$HOME/miniconda" || warning "Miniconda installation failed"
export PATH=$HOME/miniconda/bin:$PATH
rm -f "$miniconda_script"

# Install Nerd Fonts
status "Installing Nerd Fonts..."
if [[ ! -d "nerd-fonts" ]]; then
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
    sudo ./nerd-fonts/install.sh || warning "Nerd Fonts installation failed"
else
    status "Nerd Fonts repository already exists"
fi

# Install Flatpaks
status "Installing Flatpaks..."
flatpak install -y \
    com.getpostman.Postman \
    com.github.gijsgoudzwaard.image-optimizer \
    nl.hjdskes.gcolor3 || warning "Some Flatpaks failed to install"

# Install NVM
status "Installing Node Version Manager..."
if [[ ! -d "$HOME/.nvm" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash || warning "NVM installation failed"
else
    status "NVM already installed"
fi

# GNOME settings
status "Configuring GNOME settings..."
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 0

# Cleanup
status "Cleaning up..."
sudo apt-get autoclean
sudo apt-get autoremove -y
sudo apt-get clean

status "Setup complete!"
read -p "Reboot now? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
