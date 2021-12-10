#!/bin/bash

sudo add-apt-repository ppa:touchegg/stable
sudo apt-fast update
sudo apt-get install touchegg
  
sudo apt install libinput-tools xdotool
sudo gpasswd -a $USER input

#after this log out then log in again, then execute below commands

# sudo systemctl enable touchegg.service
# sudo systemctl start touchegg
