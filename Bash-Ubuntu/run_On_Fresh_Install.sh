#!/bin/bash

echo 'Updating APT...'
sudo apt-get update
echo $'\n';


echo 'Installing VnStat...'
sudo apt-get install vnstat
echo $'\n';


echo 'Installing NetHogs...'
sudo apt-get install nethogs
echo $'\n';


echo 'Installing Build-Essential...'
sudo apt-get install build-essential
echo $'\n';


echo 'Installing Gnome Tweaks...'
sudo apt-get install gnome-tweaks
echo $'\n';


echo 'Installing Network Tools...'
sudo apt-get install net-tools
echo $'\n';


echo 'Installing Github...'
sudo apt-get install git
echo $'\n';


echo 'Enabling Firewall...'
sudo ufw enable
echo $'\n';


echo 'Installing MultiMedia Codecs...'
sudo apt-get install Ubuntu-restricted-extras
echo $'\n';


echo 'Installing TLP Power Management Tool...'
sudo apt-get install tlp tlp-rdw
sudo systemct1 enable tlp
echo $'\n';


stringYES="y"


echo 'Do you want to install VLC ? y/n';
read installVLC;
if [ "$installVLC" = "$stringYES" ]; then
    echo 'Installing VLC...'
    sudo snap install vlc
else 
    echo 'Not installing VLC.';
fi
echo $'\n';



echo 'Do you want to install VLC ? y/n';
read installVLC;
if [ "$installVLC" = "$stringYES" ]; then
    echo 'Installing VLC...'
    sudo snap install vlc
else 
    echo 'Not installing VLC.';
fi
echo $'\n';


echo 'Do you want to install Skype ? y/n'
read installSkype
if [ "$installSkype" = "$stringYES" ]; then
    echo 'Installing Skype...'
    sudo snap install skype
else 
    echo 'Not installing Skype.';
fi
echo $'\n';


echo 'Do you want to install SimpleScreenRecorder ? y/n'
read installScreenRecorder
if [ "$installScreenRecorder" = "$stringYES" ]; then
    echo 'Installing SimpleScreenRecorder...'
    sudo apt-get install simplescreenrecorder
else 
    echo 'Not installing VLC.';
fi
echo $'\n';


echo 'Cleaning Up...'
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
