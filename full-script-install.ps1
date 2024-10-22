Install-Module PSReadLine -Force

# Run PowerShell as Administrator
# Set the Hosts file path
$hostsPath = "$env:windir\System32\drivers\etc\hosts"

# Add packages from https://community.chocolatey.org/packages
# Add only verified packages as the code below will install it
# without user confirm
$packages = @(
    'googlechrome'
    'git'
    'vscode'
    'spotify'
    'powertoys'
    'devtoys'
    'powershell-core'
    'visualstudio2022enterprise'
    'lazygit'
    # 'chezmoi'
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

$source = ".\profile.ps1"
$destination = [System.Environment]::GetFolderPath('MyDocuments') + "\WindowsPowerShell\profile.ps1"

# Set the IP and hostname
$ip = "127.0.0.1"
$hostname = Read-Host -Prompt "Enter the hostname"

# Create the entry
$entry = "$ip`t$hostname"

# Check if the entry already exists
if ((Get-Content -path $hostsPath) -notcontains $entry) {
    # If not, add it
    Add-Content -Path $hostsPath -Value $entry
    Write-Host "Entry added: $entry"
}
else {
    Write-Host "Entry already exists: $entry"
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

# Check if the source file exists
if (Test-Path $source) {
    # Copy the file
    Copy-Item -Path $source -Destination $destination
    Write-Output "File copied successfully."
}
else {
    Write-Output "Source file does not exist."
}
