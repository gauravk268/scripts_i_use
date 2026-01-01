#!/bin/bash

# --- Configure proxy environment variables ---
# These variables define proxy settings for applications and package managers.
# They allow traffic to be routed through a proxy server for HTTP, HTTPS, and FTP connections.
# Format: protocol://username:password@proxy_host:port/

# Set HTTP proxy
export http_proxy="http://edcguest:edcguest@172.31.102.29:3128/"   # Proxy for HTTP traffic

# Set HTTPS proxy
export https_proxy="http://edcguest:edcguest@172.31.102.29:3128/"  # Proxy for HTTPS traffic

# Set FTP proxy
export ftp_proxy="http://edcguest:edcguest@172.31.102.29:3128/"    # Proxy for FTP traffic
