# Scripts / Instructions to solve problems in Ubuntu

This repository contains the scripts as a solution for the problems that I have faced while working on Ubuntu from time to time. 

Filename holds the problem that has been solved in that file.

- `*.sh` file: meant to be run in the terminal, also holds instruction to undo the changes  
- `*.txt` file: holds instruction on how to solve the problem

---

## Files and their use are as follows:

- #### allow_gsconnect_ports_in_ufw.sh  
  After enabling the firewall, GSConnect stops working. Also, it doesn't identify any device on the same network. We have to allow the range of ports that GSConnect needs to connect to the other device.

- #### update_upgrade_autoremove_packages.sh  
  Update and upgrade all the packages in Ubuntu with one script. Also, it removes all the packages that are unwanted but have been installed.

- #### fix_bluetooth_toggle_issue.sh  
  It sometimes happens that the Bluetooth toggle doesn't get on or off. It is stuck in one position. In that case, we have to disable and enable the Bluetooth adapter to make it work.

- #### switch_wayland_to_xorg_for_screenshare.sh  
  Many times Wayland screen sharing does not work on many applications. It is seen as a black screen on platforms such as Google Meet or TeamViewer. To solve this, we have to change the display server to Xorg, after which screen sharing works appropriately.

- #### check_system_proxy_settings.sh  
  To check if proxies have been set up for the device.

- #### fix_dummy_output_sound_issue.sh  
  Sometimes it happens on Ubuntu that there is no sound from the speaker, and on changing volume, we get dummy output on the volume icon. To solve this, we have to reload ALSA. Also, if that doesn't help, one has to remove and then reinstall to make it work.

- #### git_first_time_setup.sh  
  First time setting up Git on a Linux machine.

- #### git_quick_push.sh  
  Add a default commit message, enabling the user to add, commit, and push Git with a single command.

- #### enable_internet_access_in_wine.sh  
  While using an application with Wine, the internet does not work in the applications. To solve this, follow the instructions in the file.

- #### get_motherboard_details.sh  
  With the instructions, you can get all the information about the motherboard on your system.

- #### setup_nodejs_without_sudo.sh  
  While setting up Node.js on Ubuntu, it doesn't work without sudo. To solve this, we have to copy the Node.js package to local lib and then add the bin path to the `.profile` of the current user.

- #### remove_system_proxy_settings.sh  
  If you want to remove all proxy settings from the system, run this script.

- #### run_on_fresh_install.sh  
  This script contains all the basic settings and packages that one needs for day-to-day work, and it needs time to do it one by one. So the script installs all the packages after it has been executed.

- #### set_system_proxy_settings.sh  
  If you want to set proxy settings for your system, run this script after updating the proxies.

- #### sync_dualboot_windows_ubuntu_clock.sh  
  On dual boot, Windows and Ubuntu clocks do not show the same time. To fix this issue, run the script in Ubuntu.

- #### shorten_terminal_prompt_path.sh  
  While using the terminal, if one goes too deep in the folder, there is a long path on each line that is sometimes unnecessary. Follow this instruction to show the current folder name only and the remaining as triple dots. One can check the full path anytime by the `pwd` command.

- #### enable_touchpad_gestures.sh  
  Ubuntu doesn't have touchpad gestures by default as in Windows like 3 and 4 finger swipe. To get this feature on your device, follow the instructions.

- #### ubuntu_desktop_initial_setup.sh  
  A comprehensive setup script for **Ubuntu Desktop**. It installs essential packages, configures Flatpak, sets up Zsh with Oh My Zsh and Powerlevel10k theme, installs Nerd Fonts, Docker, Miniconda, Node.js via NVM, and applies GNOME desktop settings if applicable. It also exports developer aliases to `~/.bashrc` and performs cleanup at the end.

- #### ubuntu_server_initial_setup.sh  
  A comprehensive setup script for **Ubuntu Server**. It installs essential developer tools (`build-essential`, `git`, `curl`, `wget`, etc.), configures UFW firewall, sets up Miniconda, Node.js via NVM, Java, Docker, PostgreSQL, Redis, and GitHub CLI. It also exports developer aliases to `~/.bashrc` and performs cleanup at the end.

---

## 📂 Repository Structure

```
.
├── Bash-Ubuntu
│   ├── allow_gsconnect_ports_in_ufw.sh
│   ├── check_system_proxy_settings.sh
│   ├── enable_internet_access_in_wine.sh
│   ├── enable_touchpad_gestures.sh
│   ├── fix_bluetooth_toggle_issue.sh
│   ├── fix_dummy_output_sound_issue.sh
│   ├── get_motherboard_details.sh
│   ├── remove_system_proxy_settings.sh
│   ├── set_system_proxy_settings.sh
│   ├── setup_nodejs_without_sudo.sh
│   ├── shorten_terminal_prompt_path.sh
│   ├── switch_wayland_to_xorg_for_screenshare.sh
│   ├── sync_dualboot_windows_ubuntu_clock.sh
│   ├── ubuntu_desktop_initial_setup.sh
│   ├── ubuntu_server_initial_setup.sh
│   └── update_upgrade_autoremove_packages.sh
└── README.md
```