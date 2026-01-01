#!/bin/bash

# --- Reload ALSA sound driver ---
# This command forces ALSA (Advanced Linux Sound Architecture) to reload.
# It is useful when sound stops working or the system shows "Dummy Output" instead of real audio devices.
sudo alsa force-reload

# --- Instruction ---
# After running the above command, restart your device and check if sound is working.
# If sound still does not work, proceed with the following steps:

# --- Remove and purge ALSA and PulseAudio packages ---
# This removes the audio packages completely, including configuration files.
# PulseAudio is the sound server used by Ubuntu, and ALSA provides the kernel-level sound drivers.
# Purging ensures a clean reinstall.
# sudo apt-get remove --purge alsa-base pulseaudio

# --- Reinstall ALSA and PulseAudio ---
# Reinstall the audio stack to restore proper sound functionality.
# sudo apt-get install alsa-base pulseaudio
