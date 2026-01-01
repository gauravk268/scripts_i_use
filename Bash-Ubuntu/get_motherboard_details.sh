#!/bin/bash

# --- Check motherboard and hardware information using dmidecode ---
# dmidecode is a tool that extracts hardware information from the system's DMI tables.
# It comes preinstalled on most Ubuntu systems, but if missing, install it first.

# Install dmidecode if not already present
sudo apt-get install -y dmidecode   # Install dmidecode package

# --- Find motherboard model ---
sudo dmidecode -s baseboard-product-name   # Display motherboard product name only

# --- Find detailed motherboard information ---
sudo dmidecode -t baseboard   # Show detailed information about the baseboard (motherboard)

# --- Find details about all hardware ---
sudo dmidecode   # Dump complete hardware information from DMI tables
