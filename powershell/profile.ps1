# Powershell
$path=$profile.CurrentUserAllHosts

Set-Alias c clear
Set-Alias ll ls
Set-Alias version $PSVersionTable
function web { cd D:\web_projects\ }
function up { cd .. }
function up2 { cd ../../ }
function up3 { cd ../../../ }
function up4 { cd ../../../../ }
function rmraf { del -Recurse -Force $args[0] }
function pws-edit { Start code $path }
function pws-conf { Get-Content -Path $path }
function pws-conf-path { $path }

# Git
function gm { git merge $args }
function ga { git add -A }
function gs { git status }
function gsw { git switch - }
function gcm { git commit -m $args }
function gu { git push }
function guu { git push -u origin HEAD }
function gp { git pull }
function grh { git reset --hard }
function gf { git fetch -a }
function gfp { git fetch -p }
function gl { git log --abbrev-commit }
function gd { git diff }
function gds { git diff --staged }
function gll { git log --all --decorate --oneline --graph }
function gc { git checkout $args }
function gb { git branch }
function gbr { git branch -r }
function gsl { git stash list }
function gss { git status --short }
function gsh { git show $args }

# Projects
function pni { pnpm install }
function pns { pnpm run start }
function pnb { pnpm run build }
function sb { pnpm run storybook }
