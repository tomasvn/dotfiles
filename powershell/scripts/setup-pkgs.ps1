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
 
    $response = Read-Host -Prompt "Do you want to install $($package)? (y/n)"
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
            # Try to find the executable in common installation paths
            $commonPaths = @(
                "C:\Program Files\$package",
                "C:\Program Files (x86)\$package",
                "C:\ProgramData\chocolatey\lib\$package\tools"
            )
            $found = $false
            foreach ($path in $commonPaths) {
                if (Test-Path $path) {
                    $found = $true
                    Write-Host "Package $package installed, but the command was not found. You may need to add $path to your PATH environment variable."
                    break
                }
            }
            if (-not $found) {
                Write-Host "Package $package installed, but the command was not found and the installation path could not be determined."
            }
        }
    }
    else {
        Write-Host "Skipping $package..."
    }
}
 
# Prompt to install all packages
$responseAll = Read-Host -Prompt "Do you want to install all packages? (y/n)"
if ($responseAll -eq 'y') {
    foreach ($package in $packages) {
        InstallPackage -package $package
    }
}
else {
    # Loop through each package and prompt for installation
    foreach ($package in $packages) {
        InstallPackage -package $package
    }
}
