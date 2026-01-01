#!/bin/bash
set -euo pipefail   # Exit on error, unset variable use, or failed pipe

# --- Safety Check ---
if [[ $EUID -eq 0 ]]; then
    read -p "It's not recommended to run this script as root. Continue anyway? [y/N] " -n 1 -r   # Warn if running as root
    echo
    [[ $REPLY =~ ^[Yy]$ ]] || exit 1   # Exit unless user confirms
fi

# --- Install Oh My Bash ---
if [[ ! -d "$HOME/.oh-my-bash" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"   # Install Oh My Bash if not present
fi

# --- Install apt-fast ---
sudo add-apt-repository ppa:apt-fast/stable -y   # Add apt-fast PPA
sudo apt-get update   # Refresh package lists
sudo apt-get install -y apt-fast   # Install apt-fast

# --- Ensure curl and wget ---
sudo apt-fast install -y curl wget   # Install curl and wget if missing

# --- System Update ---
sudo apt-fast update && sudo apt-fast upgrade -y   # Update and upgrade system packages
flatpak update -y || true   # Update flatpak packages if available

# --- Essential Packages ---
sudo apt-fast install -y \
    build-essential \   # Compiler and build tools
    chrome-gnome-shell \   # GNOME shell integration
    fcitx fcitx-googlepinyin \   # Input method framework with Google Pinyin
    gdebi git gnome-tweaks gparted \   # Package installer, Git, GNOME tweaks, partition editor
    neofetch nethogs net-tools \   # System info, network monitor, legacy net tools
    synaptic \   # GUI package manager
    timeshift tlp tlp-rdw \   # Backup utility, power management tools
    ubuntu-restricted-extras \   # Multimedia codecs and extras
    variety virtualbox vlc vnstat   # Wallpaper changer, virtualization, media player, network stats

# --- Firewall Setup ---
sudo ufw enable   # Enable firewall with default rules

# --- Replace Fcitx UI ---
sudo apt remove -y fcitx-ui-classic   # Remove classic Fcitx UI
sudo apt-fast install -y fcitx-ui-qimpanel   # Install modern Fcitx UI

# --- AppImageLauncher ---
sudo add-apt-repository ppa:appimagelauncher-team/stable -y   # Add AppImageLauncher PPA
sudo apt-fast install -y appimagelauncher   # Install AppImageLauncher

# --- TLP UI ---
sudo add-apt-repository ppa:linuxuprising/apps -y   # Add Linux Uprising apps PPA
sudo apt-fast install -y   # Install packages from PPA

# --- Install Zsh ---
sudo apt-fast install -y zsh   # Install Zsh shell

# --- Change Default Shell ---
chsh -s $(which zsh)   # Set Zsh as default shell for current user

# --- Install Oh My Zsh ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"   # Install Oh My Zsh if not present
fi

# --- Install Powerlevel10k Theme ---
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k   # Clone Powerlevel10k theme
fi

# --- Set Powerlevel10k Theme ---
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc   # Set Powerlevel10k as default theme

# --- Install Zsh Plugins ---
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions   # Autosuggestions plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting   # Syntax highlighting plugin
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use   # Suggest better commands plugin
git clone https://github.com/fdellwing/zsh-bat.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat   # Bat integration plugin

# --- Firewall Rules for KDE Connect ---
sudo ufw allow 1714:1764/tcp   # Allow KDE Connect TCP ports
sudo ufw allow 1714:1764/udp   # Allow KDE Connect UDP ports
sudo ufw reload   # Reload firewall rules

# --- Additional Packages ---
sudo apt-fast install -y libfuse2 ubuntu-restricted-extras unzip p7zip unrar gimp transmission audacity \
  flatpak gnome-software-plugin-flatpak gnome-shell-extension-manager chrome-gnome-shell   # Install multimedia, compression, and desktop tools

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
