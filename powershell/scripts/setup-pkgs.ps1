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
function InstallPackage {
    param (
        [string]$package
    )

    $response = Read-Host -Prompt "Do you want to install $package? (y/n)"
    if ($response -eq 'y') {
        Write-Host "Installing $package..."
        choco install -y $package

        # Check if the command exists
        $command = Get-Command $package -ErrorAction SilentlyContinue
        if ($command) {
            $installPath = $command.Source
            Write-Host "Package $package installed at: $installPath"
        }
        else {
            Write-Host "Package $package installed, but the command was not found."
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
        choco install -y $package

        # Check if the command exists
        $command = Get-Command $package -ErrorAction SilentlyContinue
        if ($command) {
            $installPath = $command.Source
            Write-Host "Package $package installed at: $installPath"
        }
        else {
            Write-Host "Package $package installed, but the command was not found."
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
