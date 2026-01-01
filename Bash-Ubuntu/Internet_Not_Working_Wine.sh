#!/bin/bash

# --- Configure Wine network capabilities ---
# By default, Wine applications may not have raw network access.
# The following command grants the wine-preloader binary the capability
# to use raw sockets (cap_net_raw), which enables network access for Wine apps.

sudo setcap cap_net_raw+epi /opt/wine-stable/bin/wine-preloader

# --- To remove internet access for Wine ---
# If you want to revoke the capability and block Wine from using raw sockets,
# uncomment and run the following line:
# sudo setcap -r /opt/wine-stable/bin/wine-preloader
