#!/bin/bash

# --- Clear proxy environment variables ---
# These environment variables are commonly used by applications and package managers
# to determine proxy settings. Setting them to empty values or unsetting them ensures
# the system no longer uses a proxy for network connections.

# Reset proxy variables to empty values
export http_proxy=     # Clear lowercase http proxy
export https_proxy=    # Clear lowercase https proxy
export HTTP_PROXY=     # Clear uppercase HTTP proxy
export HTTPS_PROXY=    # Clear uppercase HTTPS proxy

# Unset proxy variables completely
unset http_proxy       # Remove lowercase http proxy variable
unset ftp_proxy        # Remove ftp proxy variable
unset socks_proxy      # Remove socks proxy variable
unset https_proxy      # Remove lowercase https proxy variable
