#!/bin/bash

# --- Install Touchégg (multi-touch gesture recognizer for Linux) ---
# Touchégg allows you to configure custom touchpad gestures (e.g., 3-finger swipe, pinch).
# It is not included by default in Ubuntu, so we add its PPA and install it.

sudo add-apt-repository ppa:touchegg/stable -y   # Add the official Touchégg stable PPA
sudo apt-fast update                             # Update package lists using apt-fast
sudo apt-get install -y touchegg                 # Install Touchégg

# --- Install supporting tools ---
# libinput-tools: provides utilities to handle input devices
# xdotool: allows simulating keyboard/mouse input, useful for gesture actions

sudo apt install -y libinput-tools xdotool       # Install supporting tools

# --- Add current user to input group ---
# This ensures the user has permission to access input devices for gesture recognition.

sudo gpasswd -a "$USER" input

# --- Post-install instructions ---
# After running this script, log out and log back in to apply group changes.
# Then enable and start the Touchégg service with the following commands:

# sudo systemctl enable touchegg.service   # Enable Touchégg to start at boot
# sudo systemctl start touchegg            # Start Touchégg service immediately
