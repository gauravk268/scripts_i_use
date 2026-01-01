#!/bin/bash

# --- Shorten the current directory path shown in terminal prompt ---
# Reference: https://unix.stackexchange.com/questions/381113/how-do-i-shorten-the-current-directory-path-shown-on-terminal
# By default, Bash shows the full path in the prompt (PS1).
# Setting PROMPT_DIRTRIM trims the middle part of long paths, replacing it with ellipses (...).
# Example:
#   Without PROMPT_DIRTRIM: /home/user/projects/myapp/src/components
#   With PROMPT_DIRTRIM=1:  .../src/components
#
# The number specifies how many trailing directories to keep visible.

# Append PROMPT_DIRTRIM setting to ~/.bashrc so it persists across sessions
echo 'PROMPT_DIRTRIM=1' >> ~/.bashrc

# --- Instruction ---
# After adding this line, reload your shell configuration with:
#   source ~/.bashrc
#
# You can adjust the number (e.g., PROMPT_DIRTRIM=2) to keep more directories visible.
