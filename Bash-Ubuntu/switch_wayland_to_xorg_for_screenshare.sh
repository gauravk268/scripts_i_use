#!/bin/bash

# --- Fix screen sharing issues by disabling Wayland and setting Qt platform ---
# Many applications (e.g., Google Meet, TeamViewer) show a black screen when sharing
# if Ubuntu is using the Wayland display server. Switching to Xorg resolves this issue.
# Additionally, setting the Qt platform to XCB ensures better compatibility for Qt apps.

# --- Step 1: Edit GDM configuration ---
# Open the GDM custom configuration file in gedit.
# In the file, find the line "#WaylandEnable=false" and remove the "#" to uncomment it.
# This disables Wayland and forces the system to use Xorg.
sudo gedit /etc/gdm3/custom.conf

# --- Step 2: Edit environment variables ---
# Open the environment configuration file in gedit.
# Add the following line at the end of the file:
#   QT_QPA_PLATFORM=xcb
# This ensures Qt applications use the XCB backend instead of Wayland.
sudo gedit /etc/environment

# --- Step 3: Restart system ---
# After saving both files, restart your machine to apply changes.
# Upon login, the system will use Xorg instead of Wayland, and Qt apps will use XCB.
# This should fix screen sharing issues.
# sudo reboot
