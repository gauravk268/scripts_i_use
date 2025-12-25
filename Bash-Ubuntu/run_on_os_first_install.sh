#!/bin/bash
set -euo pipefail

# Avoid running as root
if [[ $EUID -eq 0 ]]; then
    read -p "It's not recommended to run this script as root. Continue anyway? [y/N] " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] || exit 1
fi

# Install Oh My Bash
if [[ ! -d "$HOME/.oh-my-bash" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

# Install apt-fast first
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt-get update
sudo apt-get install -y apt-fast

# Make sure essential tools are present
sudo apt-fast install -y curl wget

# System update
sudo apt-fast update && sudo apt-fast upgrade -y
flatpak update -y || true

# Essential packages
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

# Enable firewall
sudo ufw enable

# Replace Fcitx UI
sudo apt remove -y fcitx-ui-classic
sudo apt-fast install -y fcitx-ui-qimpanel

# AppImageLauncher
sudo add-apt-repository ppa:appimagelauncher-team/stable -y
sudo apt-fast install -y appimagelauncher

# TLP UI
sudo add-apt-repository ppa:linuxuprising/apps -y
sudo apt-fast install -y

# Install zsh
sudo apt-fast install -y zsh

# Change default shell to zsh for current user
chsh -s $(which zsh)

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Set Powerlevel10k as default theme in ~/.zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
  
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/fdellwing/zsh-bat.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat


sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp
sudo ufw reload

sudo apt-fast install libfuse2 ubuntu-restricted-extras unzip p7zip unrar gimp transmission audacity \
  flatpak gnome-software-plugin-flatpak gnome-shell-extension-manager chrome-gnome-shell -y
