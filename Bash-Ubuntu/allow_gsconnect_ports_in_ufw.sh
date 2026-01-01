#!/bin/bash

# --- Configure UFW firewall rules for KDE Connect ---
# KDE Connect requires ports 1714–1764 open for both TCP and UDP traffic
sudo ufw allow 1714:1764/udp   # Allow UDP traffic on ports 1714–1764
sudo ufw allow 1714:1764/tcp   # Allow TCP traffic on ports 1714–1764

# --- Reload firewall to apply changes ---
sudo ufw reload   # Reload UFW to activate new rules
