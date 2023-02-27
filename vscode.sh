#!/bin/bash

# Install VSCode extensions from one sh script

# Declare array of extensions
declare -a arr=(
  dbaeumer.vscode-eslint
  mrmlnc.vscode-scss
  whatwedo.twig
  wix.vscode-import-cost
  stylelint.vscode-stylelint
  esbenp.prettier-vscode
  VSpaceCode.whichkey
  Orta.vscode-twoslash-queries
)

for ext in $arr
do
  code --install-extension $ext --force
done
