# Powershell
$path = $profile.CurrentUserAllHosts
$customPath = $HOME

# ================
# Build functions
# ================

# ====
# NPM
# ====
function npi {
    npm install
}

function nps {
    npm run start
}

function npb {
    npm run build
}

# ======
# PNPM
# ======
function pni {
    pnpm install
}

function pns {
    pnpm run start
}

function pb {
    pnpm run build
}

function sb {
    pnpm run storybook
}

# ==============
# Git Functions
# ==============
function gm {
    param(
        [string]$mergePath
    )
    git merge $mergePath
}

function ga {
    git add -A
}

function gs {
    git status
}

function gsw {
    git switch -
}

function cm {
    param (
        [string]$message
    )
    git commit -m $message
}

function pu {
    git push
}

function guu {
    git push -u origin HEAD
}

function gp {
    git pull
}

function grh {
    git reset --hard
}

function gf {
    git fetch -a
}

function gfp {
    git fetch -p
}

function gl {
    git log --abbrev-commit
}

function gd {
    git diff
}

function gds {
    git diff --staged
}

function gll {
    git log --all --decorate --oneline --graph
}

function gc {
    param(
        [string]$checkoutPath
    )
    git checkout $checkoutPath
}

function gb {
    git branch
}

function gbr {
    git branch -r
}

function gst {
    git stash save
}

function gsp {
    git stash pop
}

function gsl {
    git stash list
}

function gss {
    git status --short
}

function gsh {
    param(
        [string]$logSha
    )
    git show $logSha
}

# ======================
# Navigation Functions
# ======================

function web {
    param (
        [string]$path = $customPath
    )
    Set-Location $path
}

function up {
    Set-Location ..
}

function up2 {
    Set-Location ../../
}

function up3 {
    Set-Location ../../../
}

function up4 {
    Set-Location ../../../../
}

# ================
# General aliases
# ================

function rmf {
    param (
        [string]$path
    )
    Remove-Item -Recurse -Force $path
}

function codeedit {
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

function c {
    Clear-Host
}

function ll {
    Get-ChildItem
}
