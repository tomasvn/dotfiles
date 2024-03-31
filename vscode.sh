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

for ext in $arr
do
    # Run pattern matching with flag quite and ignore give case
    if echo "$extensions" | grep -qi "^$ext"; then
        echo "$extensions is already installed. Skipping..."
    else
        echo "Installing $extensions..."
        code --install-extension "$ext"
    fi
done

echo "VS Code extensions have been installed."
