# Add packages from Scoop buckets

$pkgManagerScript = Join-Path $PSScriptRoot 'setup-pkg-manager.ps1'
if (-not (Get-Command scoop -ErrorAction SilentlyContinue) -and (Test-Path $pkgManagerScript)) {
    & $pkgManagerScript
}

$packages = @(
    'googlechrome',
    'git',
    'vscode',
    'spotify',
    'powertoys',
    'devtoys',
    'pwsh',
    'lazygit',
    'cmder',
    'posh-git'
)

function Test-ScoopPackageInstalled {
    param([string]$package)

    try {
        $installedPackages = @(scoop list 2>$null | ForEach-Object { ($_ -split '\s+')[0].Trim() } | Where-Object { $_ })
        return $installedPackages -contains $package
    }
    catch {
        return $false
    }
}

# Function to prompt for installation
function InstallPackage {
    param (
        [string]$package
    )

    $response = Read-Host -Prompt ("Do you want to install {0}? (y/n)" -f $package)
    if ($response -eq 'y') {
        Write-Host "Installing $package..."
        scoop install $package

        if (Test-ScoopPackageInstalled -package $package) {
            Write-Host "Package $package installed."
        }
        else {
            Write-Host "Package $package installed, but Scoop did not report it in the package list."
        }
    }
    else {
        Write-Host "Skipping $package..."
    }
}

# Function to install all packages without prompting
function InstallAllPackages {
    param (
        [array]$packages
    )

    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        scoop install $package

        if (Test-ScoopPackageInstalled -package $package) {
            Write-Host "Package $package installed."
        }
        else {
            Write-Host "Package $package installed, but Scoop did not report it in the package list."
        }
    }
}

# Prompt to install all packages
$responseAll = Read-Host -Prompt "Do you want to install all packages? (y/n)"
if ($responseAll -eq 'y') {
    InstallAllPackages -packages $packages
}
else {
    # Loop through each package and prompt for installation
    foreach ($package in $packages) {
        InstallPackage -package $package
    }
}
