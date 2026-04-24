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

function gcm {
    param (
        [string]$message
    )
    git commit -m $message
}

function gu {
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

function gfa {
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
    param([string]$stashIndex)
    if ($stashIndex) {
        git stash pop "stash@{$stashIndex}"
    }
    else {
        git stash pop
    }
}

function gsa {
    param([string]$stashIndex)
    if ($stashIndex) {
        git stash apply "stash@{$stashIndex}"
    }
    else {
        git stash apply
    }
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
    param(
        [Parameter(Position=0)]
        [int]$n = 1
    )

    if ($n -lt 1) { return }

    $dir = Get-Item -LiteralPath (Get-Location)
    for ($i = 0; $i -lt $n; $i++) {
        if ($dir.Parent) { $dir = $dir.Parent } else { break }
    }
    Set-Location $dir.FullName
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

function edit {
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
