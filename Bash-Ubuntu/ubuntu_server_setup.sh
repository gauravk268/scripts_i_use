#!/bin/bash

# --- System Update and Basic Tools ---
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y   # Update package lists and upgrade installed packages
sudo apt install -y build-essential git curl wget software-properties-common apt-transport-https ca-certificates \
    neofetch net-tools nethogs openssh-server p7zip synaptic ubuntu-restricted-extras unrar unzip vnstat \
    htop ncdu tmux neovim ripgrep fd-find sqlite3 tig   # Install essential dev tools, editors, monitoring, compression, and Git helpers

# --- Git Configuration ---
git config --global user.name "gauravk268"   # Set global Git username
git config --global user.email "gauravk26800@gmail.com"   # Set global Git email
echo 'export GIT_TOKEN=git_token_value' >> ~/.bashrc   # Export Git token environment variable

# --- Firewall Setup (UFW) ---
echo "Setting up Uncomplicated Firewall (UFW)..."
sudo ufw allow OpenSSH   # Allow SSH connections
sudo ufw --force enable  # Enable firewall non-interactively
echo "Firewall is active and OpenSSH is allowed."

# --- Install Miniconda (non-interactive) ---
echo "Installing Miniconda..."
wget -4 https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh   # Download Miniconda installer
bash ~/miniconda.sh -b -p $HOME/miniconda3   # Run installer in batch mode, install to ~/miniconda3
echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc   # Add Miniconda to PATH permanently

# --- Install Node.js via NVM ---
echo "Installing Node.js via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash   # Install NVM
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc   # Persist NVM environment variable
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc   # Load NVM on shell startup
source ~/.bashrc   # Reload bashrc for current session
nvm install 22     # Install Node.js v22

# --- Install Java ---
echo "Installing Java..."
sudo apt install -y openjdk-21-jdk default-jre   # Install OpenJDK 21 and default JRE

# --- Install Docker ---
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg   # Add Docker GPG key
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null   # Add Docker repo
sudo apt update   # Refresh package lists
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin   # Install Docker engine, CLI, container runtime, and Compose plugin

# --- Configure Docker Permissions ---
sudo usermod -aG docker $USER   # Add current user to docker group for non-root usage
echo "You must log out and log back in for Docker group changes to take effect."

# --- Install GitHub CLI ---
echo "Installing GitHub CLI..."
sudo apt install -y gh   # Install GitHub CLI for repo and workflow management

# --- Install Databases ---
echo "Installing PostgreSQL and Redis..."
sudo apt install -y postgresql postgresql-contrib redis-server   # Install PostgreSQL with extras and Redis server

# --- Add Developer Aliases ---
echo "Exporting developer aliases to ~/.bashrc..."
cat << 'EOF' >> ~/.bashrc

# --- Timestamp and Python ---
alias ts="echo -e '\n' && date +'%Y-%m-%d %H:%M:%S:%4N' && echo -ne '\n'"   # Print timestamp with nanoseconds
alias python="python3"                                                       # Use Python 3 by default

# --- Git Shortcuts ---
alias ga='git add'                                                           # Stage changes
alias gb='git branch'                                                        # List branches
alias gba='git branch -a'                                                    # List all branches
alias gc='git commit'                                                        # Commit changes
alias gca='git commit -v -a'                                                 # Commit all with verbose
alias gcl='git clone'                                                        # Clone repository
alias gcm='git clone -m'                                                     # Clone with mirror option
alias gco='git checkout'                                                     # Checkout branch
alias gcob='git checkout -b'                                                 # Create and checkout new branch
alias gcot='git checkout -t'                                                 # Checkout tracking branch
alias gcotb='git checkout --track -b'                                        # Create and track new branch
alias gd='git diff | mate'                                                   # Show diff (pipe to TextMate if installed)
alias gfa='git fetch -a'                                                     # Fetch all remotes
alias gfo='git fetch origin'                                                 # Fetch origin
alias glog='git log'                                                         # Show commit log
alias glogp='git log --pretty=format:"%h %s" --graph'                        # Pretty log with graph
alias gm='git merge'                                                         # Merge branch
alias gma='git merge --abort'                                                # Abort merge
alias gpl='git pull'                                                         # Pull changes
alias gps='git push'                                                         # Push changes
alias gs='git status'                                                        # Show status
alias gst='git stash'                                                        # Stash changes

# --- Navigation Shortcuts ---
alias .='cd ..; pwd'                                                         # Go up one directory
alias ..='cd ../..; pwd'                                                     # Go up two directories
alias ...='cd ../../..; pwd'                                                 # Go up three directories

# --- System Utilities ---
alias c='clear'                                                              # Clear screen
alias h='history'                                                            # Show command history
alias hg='history | grep $1'                                                 # Search history
alias rl='clear; source ~/.bashrc'                                           # Reload bashrc
alias fh='find . -name '                                                     # Find files by name

# --- Listing Shortcuts ---
alias ll='ls -la'                                                            # Long listing
alias lf='ls -alF'                                                           # Long listing with file type indicators
alias la='ls -A'                                                             # List all except . and ..
alias ls='ls -CF'                                                            # Default ls with classification
alias lt='ls --human-readable --size -1 -S --classify'                       # Sort by file size
alias lu='du -sh * | sort -h'                                                # Sort by folder/file size
alias lc='find . -type f | wc -l'                                            # Count files recursively
alias ld='ls -d */'                                                          # List directories only

# --- Archiving Shortcuts ---
alias untar='tar -zxvf $1'                                                   # Extract tar.gz
alias tar='tar -cczvf $1'                                                    # Create tar.gz
alias mkdir="mkdir -p -v"                                                    # Create directories with parents and verbose

EOF

echo "Development server setup script finished. Aliases exported to ~/.bashrc"
