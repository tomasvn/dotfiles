# Powershell
Set-Alias c clear
Set-Alias ll ls
function web { cd D:\web_projects\ }
function up { cd .. }
function up2 { cd ../../ }
function up3 { cd ../../../ }
function up4 { cd ../../../../ }

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
function pni { pnpm install }
function pns { pnpm run start }
function pnb { pnpm run build }
function sb { pnpm run storybook }