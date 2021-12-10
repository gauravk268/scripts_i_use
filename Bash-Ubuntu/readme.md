# Scripts / Instructions to solve problems in Ubuntu

This repository contains the scripts as a solution for the problems that I have faced while working on Ubuntu from time to time. 

Filename holds the problem that has been solved in that file.

*.sh file: meant to be run in the terminal, also holds instruction to undo the changes</br>
*.txt file: holds instruction on how to solve the problem

## Files and their use are as follows:

- #### allow_gsconnect_on_ufw.sh
    After enabling the firewall, gsconnect stops working. Also, it doesn't identify any device on the same network. We have to allow the range of ports that gsconnect needs to connect to the other device.

- #### apt_Update.sh
    Update and Upgrade all the packages in Ubuntu with one script. Also, it removes all the packages that are unwanted but have been installed.

- #### Bluetooth_not_turning_on.sh
    It sometimes happens that the Bluetooth toggle doesn't get on or off. It is stuck in one position. In that case, we have to disable and enable the Bluetooth adapter to make it work.

- #### Change_Wayland_to_XorG.txt
    Many times because Wayland screen sharing feature does not work on many applications. It is seen as a black screen on platforms such as google meet, TeamViewer. To solve this, we have to change the display server to Xorg, after which screen sharing works appropriately.

- #### check_If_Proxy.sh
    To check if proxies have been set up for the device.

- #### Dummy_output_sound.txt
    Sometimes it happens on Ubuntu that there is no sound from the speaker, and on changing volume, we get dummy output on the volume icon. To solve this, we have to reload alsa. Also, if that doesn't help, one has to remove and then again reinstall to make it work.

- #### git_First_Time.sh
    First time setting up git on a Linux machine.

- #### git_push.sh
    Add a default commit message, enabling the user to add, commit, push git with a single command.

- #### Internet_Not_Working_Wine.sh
    While using an application with Wine, the internet does not work in the applications. To solve this, follow the instructions in the file.

- #### motherboard_info.txt
    With the instructions, you can get all the information about the motherboard on your system.

- #### nodejs_Setup_Without_Sudo.sh
    While setting up nodejs on Ubuntu, it doesn't work without sudo. To solve this, we have to copy the nodejs package to local lib and then add the bin path to the .profile of the current user.

- #### remove_Proxy.sh
    If you want to remove all proxy settings from the system, run this script.


- #### run_On_Fresh_Install.sh
    This script contains all the basic settings and packages that one needs for day-to-day work, and it needs time to do it one by one. So the script installs all the packages after it has been executed.

- #### set_Proxy.sh
    If you want to set proxy settings for your system, run this script after updating the proxies.

- #### Sync_Windows_and_Ubuntu_Clock.sh
    On dual boot, Windows and Ubuntu clocks do not show the same time. To fix this issue, run the script in Ubuntu.

- #### to_shorten_the_path_showing_in_terminal.txt
    While using the terminal, if one goes too deep in the folder, there is a long path on each line that is sometimes unnecessary. Follow this instruction to show the current folder name only and the remaining as triple dots. One can check the full path anytime by the "pwd" command.

- #### touchpad_Gesture.sh
    Ubuntu doesn't have touchpad gestures by default as in Windows like 3 and 4 finger swipe. To get this feature on your device, follow the instructions.