#!/bin/bash

# --- Install Node.js manually without using package manager ---
# This script assumes you have already downloaded and extracted the Node.js tarball
# (e.g., node-v16.13.0-linux-x64) into your current working directory.

# Copy the extracted Node.js folder to /usr/local/lib/nodejs
sudo cp -r node-v16.13.0-linux-x64/ /usr/local/lib/nodejs/   # Copy Node.js binaries to system-wide location

# Change directory to the installation path
cd /usr/local/lib/nodejs/   # Navigate to Node.js installation directory

# Change ownership of the Node.js folder to the current user
sudo chown $USER node-v16.13.0-linux-x64/   # Ensure user has permissions to manage Node.js installation

# Edit the user's profile to update PATH
gedit ~/.profile   # Open .profile in gedit for manual editing

# --- Instruction ---
# Add the following line at the end of ~/.profile to include Node.js in PATH:
# PATH="/usr/local/lib/nodejs/node-v16.13.0-linux-x64/bin:$PATH"
