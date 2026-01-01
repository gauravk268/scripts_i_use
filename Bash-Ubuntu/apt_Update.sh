#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean   # Remove retrieved package files that can no longer be downloaded
sudo apt-get autoremove -y   # Remove packages that are no longer required
sudo apt-get clean   # Clear out the local repository of retrieved package files
