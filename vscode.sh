#!/bin/bash

# Install VSCode extensions from one sh script
# https://github.com/CoreyMSchafer/dotfiles/blob/master/vscode.sh

# Declare array of extensions
declare -a arr=(
    dbaeumer.vscode-eslint
    SomewhatStationery.some-sass
    wix.vscode-import-cost
    stylelint.vscode-stylelint
    esbenp.prettier-vscode
    Orta.vscode-twoslash-queries
    Vue.volar
    teabyii.ayu
    eamodio.gitlens
    pflannery.vscode-versionlens
    PKief.material-icon-theme
)

extensions=$(code --list-extensions)

# Define color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

for ext in "${arr[@]}"
do
    # Run pattern matching with flag quite and ignore case
    if echo "$extensions" | grep -qi "^$ext"; then
        echo -e "${RED}$ext is already installed. Skipping...${NC}"
    else
        echo -e "${GREEN}Installing $ext...${NC}"
        code --install-extension "$ext"
    fi
done