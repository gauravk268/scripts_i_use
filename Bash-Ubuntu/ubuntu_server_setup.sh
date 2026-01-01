#!/bin/bash

# System Update and Basic Tools
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget software-properties-common apt-transport-https ca-certificates \
    neofetch net-tools nethogs openssh-server p7zip synaptic ubuntu-restricted-extras unrar unzip vnstat

# Firewall Setup (UFW)
echo "Setting up Uncomplicated Firewall (UFW)..."
sudo ufw allow OpenSSH
sudo ufw --force enable
echo "Firewall is active and OpenSSH is allowed."

# Install Miniconda (non-interactive)
wget -4 https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda3
echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc

# Install Node Version Manager and Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
source ~/.bashrc
nvm install 22

# Install java
sudo apt-fast install openjdk-21-jdk default-jre

# Install Docker
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add current user to the docker group
sudo usermod -aG docker $USER
echo "You must log out and log back in for Docker group changes to take effect."

echo "Development server setup script finished."
