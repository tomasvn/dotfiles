# Powershell
$path=$profile.CurrentUserAllHosts

Set-Alias c clear
Set-Alias ll ls

function web { Set-Location @args }
function up { Set-Location .. }
function up2 { Set-Location ../../ }
function up3 { Set-Location ../../../ }
function up4 { Set-Location ../../../../ }
function rmraf { Remove-Item -Recurse -Force @args }
function pwsedit { Start-Process code $path }
function pwsget { Get-Content -Path $path }
function pwsconf { $path }

# Git
function gm { git merge @args }
function ga { git add -A }
function gs { git status }
function gsw { git switch - }
function gcm { git commit -m @args }
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
function gc { git checkout @args }
function gb { git branch }
function gbr { git branch -r }
function gst { git stash save }
function gsp { git stash pop }
function gsl { git stash list }
function gss { git status --short }
function gsh { git show @args }

# Projects
function pni { pnpm install }
function pns { pnpm run start }
function pnb { pnpm run build }
function sb { pnpm run storybook }