#!/bin/bash

# --- Fix Bluetooth not working issue on Ubuntu ---
# Reference: https://askubuntu.com/questions/1231074/ubuntu-20-04-bluetooth-not-working
# Sometimes the Bluetooth adapter gets stuck and does not toggle on/off.
# Reloading the btusb kernel module can resolve this issue.

sudo rmmod btusb     # Remove the btusb kernel module (Bluetooth USB driver)
sudo modprobe btusb  # Reinsert the btusb kernel module to reload the driver
