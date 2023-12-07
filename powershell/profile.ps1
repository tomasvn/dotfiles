# Get current profile of pws and open config in vscode
# 1. Run this in pws -> code $PROFILE.CurrentUserAllHosts
# 2. Load config from folder
# - . $env:USERPROFILE\<config_folder_path>\<file>.ps1

# Aliases
Set-Alias web ''
Set-Alias c clear
Set-Alias ll ls
Set-Alias -Name .. -Value 'cd ..'
Set-Alias -Name .2 -Value 'cd ../../'
Set-Alias -Name .3 -Value 'cd ../../../'
Set-Alias -Name .4 -Value 'cd ../../../../'

# Git
function ga { git add -A }
function gs { git status }
function gsw { git switch - }
function gcm { git commit -m $args[0] }
function gu { git push }
function guu { git push -u origin HEAD }
function gp { git pull }
function gf { git fetch -a }
function gfp { git fetch -p }
function gl { git log }
function gd { git diff }
function gds { git diff --staged }
function gll { git log --all --decorate --oneline --graph }
function gc { git checkout $args[0] }
function gb { git branch }
function gbr { git branch -r }
function gsl { git stash list }
function gss { git status --short }
function gsh { git show $args[0] }

# Projects
function pns { pnpm run start }
function pnb { pnpm run build }
function sb { pnpm run storybook }