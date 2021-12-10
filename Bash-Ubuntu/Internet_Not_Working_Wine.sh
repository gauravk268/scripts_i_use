#!/bin/bash

sudo setcap cap_net_raw+epi /opt/wine-stable/bin/wine-preloader

# to remove the internet access
# sudo setcap -r /opt/wine-stable/bin/wine-preloader
