# Function to prompt for uninstallation
function UninstallPackage {
    param (
        [string]$package
    )

    $response = Read-Host -Prompt "Do you want to uninstall $package? (y/n)"
    if ($response -eq 'y') {
        Write-Host "Uninstalling $package..."
        choco uninstall -y $package

        # Check if the command exists
        $command = Get-Command $package -ErrorAction SilentlyContinue
        if ($command) {
            Write-Host "Package $package uninstalled."
        }
        else {
            Write-Host "Package $package was not found."
        }
    }
    else {
        Write-Host "Skipping $package..."
    }
}

# Get the list of installed Chocolatey packages
$installedPackages = choco list --local-only | Select-String -Pattern '^[^ ]+' | ForEach-Object { $_.Matches[0].Value }

# Prompt to uninstall all packages
$responseAll = Read-Host -Prompt "Do you want to uninstall all packages? (y/n)"
if ($responseAll -eq 'y') {
    foreach ($package in $installedPackages) {
        UninstallPackage -package $package
    }
}
else {
    # Loop through each package and prompt for uninstallation
    foreach ($package in $installedPackages) {
        UninstallPackage -package $package
    }
}
