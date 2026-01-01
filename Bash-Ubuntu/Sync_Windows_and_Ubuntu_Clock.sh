#!/bin/bash

# --- Fix dual-boot time mismatch between Windows and Ubuntu ---
# Reference: https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
# By default, Linux uses UTC for the hardware clock, while Windows uses local time.
# This difference can cause the system clock to show incorrect times when switching between OSes.
# The following command configures Ubuntu to interpret the hardware clock as local time.

# Set Ubuntu to read hardware clock as local time
timedatectl set-local-rtc 1 --adjust-system-clock

# --- Verify settings ---
# This command shows the current time settings and confirms whether local RTC is enabled.
timedatectl

# --- Undo the change ---
# If you want Ubuntu to revert to using UTC for the hardware clock, run:
# timedatectl set-local-rtc 0 --adjust-system-clock
