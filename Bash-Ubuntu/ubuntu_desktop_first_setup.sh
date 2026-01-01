#!/bin/bash
set -euo pipefail   # Exit on error, unset variable use, or failed pipe

# --- Color codes for output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'   # No Color

# --- Helper functions ---
status() { echo -e "${GREEN}[*]${NC} $1"; }   # Print status messages
warning() { echo -e "${YELLOW}[!]${NC} $1"; } # Print warnings
error() { echo -e "${RED}[X]${NC} $1" >&2; exit 1; }   # Print error and exit

# --- Safety check: discourage running as root ---
if [[ $EUID -eq 0 ]]; then
  warning "It's not recommended to run this script as root. Some operations may not work correctly."   # Warn if running as root
  read -p "Continue anyway? [y/N] " -n 1 -r   # Ask for confirmation
  echo
  [[ $REPLY =~ ^[Yy]$ ]] || exit 1   # Exit unless user confirms
fi

# --- Install Oh My Bash (interactive, best-effort) ---
if [[ ! -d "$HOME/.oh-my-bash" ]]; then
  status "Installing Oh My Bash..."   # Begin installing Oh My Bash
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || warning "Oh My Bash installation failed"   # Run installer
else
  status "Oh My Bash already installed"   # Already present
fi

# --- Configure apt-fast for parallel downloads ---
status "Setting up apt-fast..."   # Begin apt-fast setup
sudo add-apt-repository ppa:apt-fast/stable -y   # Add apt-fast PPA
sudo apt-get update   # Refresh package lists
sudo apt-get install -y apt-fast || error "Failed to install apt-fast"   # Install apt-fast

# --- Ensure basic network tools present ---
sudo apt-fast install -y curl wget   # Ensure curl and wget are available

# --- System update/upgrade ---
status "Updating system packages..."   # Begin system updates
sudo apt-fast update && sudo apt-fast upgrade -y   # Update and upgrade packages

# --- Install essential APT packages (desktop/dev) ---
status "Installing APT packages..."   # Begin essential package installation
sudo apt-fast install -y \
  build-essential \   # Compiler and build tools
  fcitx fcitx-googlepinyin \   # Input method framework + Google Pinyin
  gdebi git gnome-tweaks gparted \   # Package installer, Git, GNOME tweaks, partition editor
  neofetch nethogs net-tools \   # System info, network monitor, legacy net tools
  synaptic \   # GUI package manager
  timeshift tlp tlp-rdw \   # Backup utility, power management tools
  ubuntu-restricted-extras \   # Multimedia codecs and extras
  variety virtualbox vlc vnstat \   # Wallpaper changer, virtualization, media player, network stats
  unzip p7zip unrar gimp transmission audacity \   # Compression tools and multimedia apps
  flatpak gnome-software-plugin-flatpak gnome-shell-extension-manager chrome-gnome-shell || warning "Some packages failed to install"   # Flatpak and GNOME integration

# --- Enable UFW firewall ---
status "Enabling UFW firewall..."   # Begin firewall setup
sudo ufw --force enable   # Enable firewall non-interactively

# --- KDE Connect ports (optional networking) ---
sudo ufw allow 1714:1764/tcp   # Allow KDE Connect TCP ports
sudo ufw allow 1714:1764/udp   # Allow KDE Connect UDP ports
sudo ufw reload   # Reload firewall rules

# --- Replace Fcitx UI (optional) ---
status "Configuring Fcitx UI..."   # Begin Fcitx UI change
sudo apt remove -y fcitx-ui-classic   # Remove classic Fcitx UI
sudo apt-fast install -y fcitx-ui-qimpanel || warning "Fcitx UI installation failed"   # Install Qimpanel UI

# --- AppImageLauncher (manage AppImage integration) ---
status "Installing AppImageLauncher..."   # Begin AppImageLauncher install
sudo add-apt-repository ppa:appimagelauncher-team/stable -y   # Add AppImageLauncher PPA
sudo apt-fast update   # Refresh lists after PPA
sudo apt-fast install -y appimagelauncher || warning "AppImageLauncher installation failed"   # Install AppImageLauncher

# --- TLP UI and service ---
status "Installing TLP UI..."   # Begin TLP UI install
sudo add-apt-repository ppa:linuxuprising/apps -y   # Add Linux Uprising PPA
sudo apt-fast update   # Refresh lists after PPA
sudo apt-fast install -y tlpui || warning "TLP UI installation failed"   # Install TLP UI
sudo tlp start   # Start TLP service
sudo systemctl enable tlp || warning "Failed to enable TLP"   # Enable TLP on boot

# --- Install Microsoft Edge (example browser) ---
status "Installing Microsoft Edge..."   # Begin Edge install
edge_deb="microsoft-edge-stable.deb"   # Local filename
wget -q "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_135.0.3179.73-1_amd64.deb" -O "$edge_deb"   # Download Edge .deb
sudo apt install -y "./$edge_deb" || warning "Microsoft Edge installation failed"   # Install Edge
rm -f "$edge_deb"   # Remove installer file

# --- Install Docker (engine, CLI, compose plugin) ---
status "Installing Docker..."   # Begin Docker install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg   # Add Docker GPG key
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null   # Add Docker repo
sudo apt-fast update   # Refresh package lists
sudo apt-fast install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || warning "Some Docker packages failed to install"   # Install Docker packages
sudo usermod -aG docker "$USER"   # Add current user to docker group for non-root usage

# --- Install Miniconda (non-interactive) ---
status "Installing Miniconda..."   # Begin Miniconda install
MINICONDA_SH="Miniconda3-latest-Linux-x86_64.sh"   # Installer name
wget -q "https://repo.anaconda.com/miniconda/$MINICONDA_SH"   # Download installer
bash "$MINICONDA_SH" -b -p "$HOME/miniconda" || warning "Miniconda installation failed"   # Install in batch mode to $HOME/miniconda
echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc   # Add Miniconda to PATH permanently
rm -f "$MINICONDA_SH"   # Cleanup installer

# --- Install NVM and Node.js ---
status "Installing Node Version Manager (NVM)..."   # Begin NVM install
if [[ ! -d "$HOME/.nvm" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash || warning "NVM installation failed"   # Install NVM
else
  status "NVM already installed"   # Skip if present
fi
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc   # Persist NVM environment variable
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc   # Load NVM on shell startup
# shellcheck disable=SC1090
source ~/.bashrc   # Reload bashrc for current session (won't persist for non-interactive shells)
nvm install 22 || warning "Node.js v22 installation failed"   # Install Node.js v22

# --- Install Zsh and Oh My Zsh (theme + plugins) ---
status "Installing Zsh and Oh My Zsh..."   # Begin Zsh/OMZ setup
sudo apt-fast install -y zsh || warning "Zsh installation failed"   # Install Zsh
chsh -s "$(which zsh)" || warning "Failed to change default shell to zsh"   # Switch default shell to Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || warning "Oh My Zsh installation failed"   # Install Oh My Zsh
else
  status "Oh My Zsh already installed"   # Already present
fi
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"   # Clone Powerlevel10k theme
fi
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc || warning "Failed to set Powerlevel10k theme"   # Set theme
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || true   # Autosuggestions plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || true   # Syntax highlighting plugin
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use" || true   # Suggest better commands plugin
git clone https://github.com/fdellwing/zsh-bat.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat" || true   # Bat integration plugin

# --- Install Nerd Fonts ---
status "Installing Nerd Fonts..."   # Begin Nerd Fonts install
if [[ ! -d "nerd-fonts" ]]; then
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git   # Clone Nerd Fonts repo
  sudo ./nerd-fonts/install.sh || warning "Nerd Fonts installation failed"   # Run installer script
else
  status "Nerd Fonts repository already exists"   # Repo already present
fi

# --- Ensure Flatpak remote and install apps ---
status "Configuring Flatpak and installing apps..."   # Begin Flatpak config
if ! flatpak remote-list | grep -q flathub; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || warning "Failed to add Flathub remote"   # Add Flathub if missing
fi
flatpak update -y || warning "Flatpak update failed"   # Update Flatpaks
flatpak install -y \
  com.getpostman.Postman \
  com.github.gijsgoudzwaard.image-optimizer \
  nl.hjdskes.gcolor3 || warning "Some Flatpaks failed to install"   # Install requested Flatpak apps

# --- GNOME settings (conditional) ---
if [[ "${XDG_CURRENT_DESKTOP:-}" == *"GNOME"* ]] || [[ "${XDG_SESSION_DESKTOP:-}" == *"GNOME"* ]]; then
  status "Configuring GNOME settings..."   # Begin GNOME settings
  gsettings set org.gnome.desktop.interface show-battery-percentage true   # Show battery percentage
  gsettings set org.gnome.desktop.interface clock-show-seconds true   # Show seconds in clock
  gsettings set org.gnome.desktop.interface clock-show-weekday true   # Show weekday in clock
  gsettings set org.gnome.desktop.interface clock-format '24h'   # Use 24h clock format
  gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 0 || warning "Dash-to-dock setting failed"   # Disable pressure threshold
else
  status "Skipping GNOME settings (not a GNOME environment)"   # Not GNOME
fi

# --- Developer aliases (persist in ~/.bashrc) ---
status "Exporting developer aliases to ~/.bashrc..."   # Begin alias export
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

# --- Cleanup ---
status "Cleaning up..."   # Begin cleanup
sudo apt-get autoclean   # Remove retrieved package files that can no longer be downloaded
sudo apt-get autoremove -y   # Remove packages that are no longer required
sudo apt-get clean   # Clear out the local repository of retrieved package files

status "Setup complete! Log out and back in to apply Docker group and shell changes."   # Final status
read -p "Reboot now? [y/N] " -n 1 -r   # Prompt for reboot
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo reboot   # Reboot system
fi