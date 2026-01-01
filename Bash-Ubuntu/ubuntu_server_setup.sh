#!/bin/bash

# System Update and Basic Tools
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget software-properties-common apt-transport-https ca-certificates neofetch net-toolsnethogs openssh-serverp7zip synaptic ubuntu-restricted-extras unrar unzip vnstat 

# Firewall Setup (UFW)
echo "Setting up Uncomplicated Firewall (UFW)..."
sudo ufw allow OpenSSH
sudo ufw enable -y
echo "Firewall is active and OpenSSH is allowed."

# Install Python tools (Python 3 is default in modern Ubuntu)
mkdir -p miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3/miniconda.sh
bash miniconda3/miniconda.sh -b -u -p miniconda3

# Install Node Version Manager and Node 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install v22

# Install Docker
echo "Installing Docker..."
curl -fsSL download.docker.com | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] download.docker.com $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add current user to the docker group to run docker without sudo
sudo usermod -aG docker $USER
echo "You must log out and log back in for Docker group changes to take effect."

echo "Development server setup script finished."
