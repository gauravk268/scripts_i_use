#!/bin/bash
# https://askubuntu.com/questions/1231074/ubuntu-20-04-bluetooth-not-working

sudo rmmod btusb
sudo modprobe btusb
