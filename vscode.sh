#!/bin/bash

# Install VSCode extensions from one sh script

# Declare array of extensions
declare -a arr=(
	dbaeumer.vscode-eslint
	SomewhatStationery.some-sass
	whatwedo.twig
	wix.vscode-import-cost
	stylelint.vscode-stylelint
	esbenp.prettier-vscode
	Orta.vscode-twoslash-queries
	Vue.vscode-typescript-vue-plugin
	Vue.volar
)

for ext in $arr
do
	code --install-extension $ext --force
done
