#!/bin/bash
# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/

# to setting ubuntu to read current time as local time
timedatectl set-local-rtc 1 --adjust-system-clock

# to check settings
timedatectl

# to undo, run this command
# timedatectl set-local-rtc 0 --adjust-system-clock

