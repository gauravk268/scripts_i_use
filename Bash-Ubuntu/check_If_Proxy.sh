#!/bin/bash

# --- Check proxy environment variables ---
# These variables are commonly used to configure HTTP/HTTPS proxy settings in Linux.
# Printing them helps verify whether a proxy is set for the current session.

echo $http_proxy    # Show lowercase http_proxy (if set)
echo $https_proxy   # Show lowercase https_proxy (if set)
echo $HTTPS_PROXY   # Show uppercase HTTPS_PROXY (if set)
echo $HTTP_PROXY    # Show uppercase HTTP_PROXY (if set)
