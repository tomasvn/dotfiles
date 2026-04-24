# Ensure TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Determine user module folder (Windows PowerShell vs PowerShell Core)
if ($PSVersionTable.PSEdition -eq 'Core') {
    $userModulePath = Join-Path $env:USERPROFILE 'Documents\PowerShell\Modules'
}
else {
    $userModulePath = Join-Path $env:USERPROFILE 'Documents\WindowsPowerShell\Modules'
}

if (-not (Test-Path $userModulePath)) {
    New-Item -ItemType Directory -Path $userModulePath -Force | Out-Null
    Write-Host "Created module folder: $userModulePath"
}

# Ensure NuGet provider and PSGallery available
try {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser -ErrorAction Stop
}
catch {
    Write-Warning "Install-PackageProvider (NuGet) failed: $_"
}

try {
    if (-not (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue)) {
        Register-PSRepository -Default -ErrorAction Stop
    }
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
}
catch {
    Write-Warning "PSGallery registration/trust failed: $_"
}

# Install PSReadLine for current user
try {
    Install-Module PSReadLine -Force -Scope CurrentUser -AllowClobber -ErrorAction Stop -Verbose
    Import-Module PSReadLine -ErrorAction SilentlyContinue
}
catch {
    Write-Warning "Install-Module PSReadLine failed: $_"
    Write-Host "Check PSModulePath and try again or run PowerShell as admin if necessary."
    return
}

# Configure PSReadLine options (only if module is available)
if (Get-Module -ListAvailable -Name PSReadLine) {
    try {
        Set-PSReadLineOption -PredictionSource History
        Set-PSReadLineOption -PredictionViewStyle ListView
        Write-Host "PSReadLine installed and configured."
    }
    catch {
        Write-Warning "Failed to configure PSReadLine options: $_"
    }
}
else {
    Write-Warning "PSReadLine module not found after install."
}