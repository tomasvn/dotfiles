# Add packages from https://community.chocolatey.org/packages
$packages = @(
    'googlechrome',
    'git',
    'vscode',
    'spotify',
    'powertoys',
    'devtoys',
    'powershell-core',
    'visualstudio2022enterprise',
    'lazygit',
    'dotnet-6.0-aspnetruntime',
    'cmder',
    'poshgit'
)

# Function to prompt for installation
function Prompt-InstallPackage {
    param (
        [string]$package
    )

    $response = Read-Host -Prompt "Do you want to install $package? (y/n)"
    if ($response -eq 'y') {
        Write-Host "Installing $package..."
        choco install -y $package
        $installPath = (Get-Command $package).Source
        Write-Host "Package $package installed at: $installPath"
    } else {
        Write-Host "Skipping $package..."
    }
}

# Prompt to install all packages
$responseAll = Read-Host -Prompt "Do you want to install all packages? (y/n)"
if ($responseAll -eq 'y') {
    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        choco install -y $package
        $installPath = (Get-Command $package).Source
        Write-Host "Package $package installed at: $installPath"
    }
} else {
    # Loop through each package and prompt for installation
    foreach ($package in $packages) {
        Prompt-InstallPackage -package $package
    }
}
