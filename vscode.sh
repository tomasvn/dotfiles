#!/bin/bash

# Install VSCode extensions from one sh script

for ext in CoenraadS.bracket-pair-colorizer dbaeumer.vscode-eslint mrmlnc.vscode-scss whatwedo.twig wix.vscode-import-cost stylelint.vscode-stylelint
do
  code --install-extension $ext --force
done