sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
sudo apt-get install vnstat nethogs build-essential gnome-tweaks net-tools git tlp tlp-rdw simplescreenrecorder firmware-b43-installer chrome-gnome-shell zsh broadcom-sta-common broadcom-sta-source broadcom-sta-dkms linux-headers-$(uname -r)
sudo ufw enable
sudo systemctl enable tlp
sudo apt-get purge bcmwl-kernel-source
sudo apt-fast upgrade -y
sudo apt autoremove
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean

zsh --version
echo $SHELL
chsh -s $(which zsh)
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
