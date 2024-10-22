#!/bin/bash

echo "  _____               _______          _ _                 "
echo " |  __ \             |__   __|        | | |                "
echo " | |  | | _____   __    | | ___   ___ | | |__   _____  __  "
echo " | |  | |/ _ \ \ / /    | |/ _ \ / _ \| | '_ \ / _ \ \/ /  "
echo " | |__| |  __/\ V /     | | (_) | (_) | | |_) | (_) >  <   "
echo " |_____/ \___| \_/      |_|\___/ \___/|_|_.__/ \___/_/\_\  "
echo "                                                           "

# Download and execute the vscode.sh script, then remove it
curl -s -o vscode.sh https://raw.githubusercontent.com/tomasvn/dotfiles/main/vscode.sh && bash vscode.sh

# Copy the .bashrc file from the GitHub repository
curl -s -o ~/.bashrc https://raw.githubusercontent.com/tomasvn/dotfiles/main/bash/.bashrc