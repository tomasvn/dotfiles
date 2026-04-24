# Elevate once if required
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$DevToolboxHeader = @'
  _____               _______          _ _                 
 |  __ \             |__   __|        | | |                
 | |  | | _____   __    | | ___   ___ | | |__   _____  __  
 | |  | |/ _ \ \ / /    | |/ _ \ / _ \| | '_ \ / _ \ \/ /  
 | |__| |  __/\ V /     | | (_) | (_) | | |_) | (_) >  <   
 |_____/ \___| \_/      |_|\___/ \___/|_|_.__/ \___/_/\_\  
                                                          
'@

Write-Host $DevToolboxHeader -ForegroundColor Cyan

# Environment / safety
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$repoRoot = Split-Path -Parent $PSCommandPath
$scriptsDir = Join-Path $repoRoot 'powershell\scripts'

$shellScripts = @(
    'setup-pkg-manager.ps1',
    'setup-pkgs.ps1',
    'setup-pws.ps1',
    'setup-localhost.ps1',
    'setup-profile.ps1'
) | ForEach-Object { Join-Path $scriptsDir $_ }

$env:DOTFILES_FROM_FULL_INSTALL = '1'

foreach ($script in $shellScripts) {
    if (Test-Path $script) {
        Write-Host "Running $([IO.Path]::GetFileName($script))..."
        try {
            & $script
        } catch {
            Write-Warning "Script failed: $script — $_"
        }
        Start-Sleep -Seconds 2
    } else {
        Write-Warning "Missing script: $script"
    }
}

Remove-Item Env:DOTFILES_FROM_FULL_INSTALL -ErrorAction SilentlyContinue

# Profile install (safe copy/backup)
$source = Join-Path $repoRoot 'powershell\profile.ps1'
$destination = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'WindowsPowerShell\profile.ps1'

if (Test-Path $source) {
    if (Test-Path $destination) {
        Copy-Item -Path $destination -Destination "$destination.bak" -Force
        Write-Host "Backed up existing profile to $destination.bak"
    } else {
        $destDir = Split-Path $destination -Parent
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
    }

    Copy-Item -Path $source -Destination $destination -Force
    Write-Host "Copied profile to $destination"
} else {
    Write-Warning "Profile source not found: $source"
}