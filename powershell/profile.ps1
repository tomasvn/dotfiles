# Powershell
$path = $profile.CurrentUserAllHosts
$customPath = $HOME

# Build functions
function npi { npm install }

function nps { npm run start }

function npb { npm run build }

function pni { pnpm install }

function pns { pnpm run start }

function pb { pnpm run build }

function sb { pnpm run storybook }

# Git Functions
function gm {
    param(
        [string]$mergePath
    )
    git merge $mergePath
}

function ga { git add -A }

function gs { git status }

function gsw { git switch - }

function gcm {
    param (
        [string]$message
    )
    git commit -m $message
}

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

function gc {
    param(
        [string]$checkoutPath
    )
    git checkout $checkoutPath
}

function gb { git branch }

function gbr { git branch -r }

function gst { git stash save }

function gsp { git stash pop }

function gsl { git stash list }

function gss { git status --short }

function gsh {
    param(
        [string]$logSha
    )

    git show $logSha
}

# Navigation Functions
function web {
    param (
        [string]$path = $customPath
    )
    Set-Location $path
}

function up { Set-Location .. }

function up2 { Set-Location ../../ }

function up3 { Set-Location ../../../ }

function up4 { Set-Location ../../../../ }

function rmaf {
    param (
        [string]$path
    )
    Remove-Item -Recurse -Force $path
}

function pwsedit {
    param (
        [string]$path
    )
    Start-Process code $path
}

function pwsget {
    param (
        [string]$path
    )
    Get-Content -Path $path
}

function pwsconf {
    param (
        [string]$path
    )
    $path
}

# General aliases
Set-Alias c clear
Set-Alias ll ls

# Navigation
Set-Alias web web
Set-Alias up up
Set-Alias up2 up2
Set-Alias up3 up3
Set-Alias up4 up4
Set-Alias rmaf rmaf
Set-Alias pwsedit pwsedit
Set-Alias pwsget pwsget
Set-Alias pwsconf pwsconf

# Git
Set-Alias gm gm
Set-Alias ga ga
Set-Alias gs gs
Set-Alias gsw gsw
Set-Alias gcm gcm
Set-Alias gu gu
Set-Alias guu guu
Set-Alias gp gp
Set-Alias grh grh
Set-Alias gf gf
Set-Alias gfp gfp
Set-Alias gl gl
Set-Alias gd gd
Set-Alias gds gds
Set-Alias gll gll
Set-Alias gc gc
Set-Alias gb gb
Set-Alias gbr gbr
Set-Alias gst gst
Set-Alias gsp gsp
Set-Alias gsl gsl
Set-Alias gss gss
Set-Alias gsh gsh

# Projects
Set-Alias pni pni
Set-Alias pns pns
Set-Alias pb pb
Set-Alias sb sb

Set-Alias npi npi
Set-Alias nps nps
Set-Alias npb npb
