# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Restart script with elevated privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

Install-Module PSReadLine -Force -Scope CurrentUser

# Check and install chocolatey
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    Write-Host "Chocolatey is already installed."
}
else {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
}

# Run PowerShell as Administrator
# Set the Hosts file path
$hostsPath = "$env:windir\System32\drivers\etc\hosts"

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


$source = ".\powershell\profile.ps1"
$destination = [System.Environment]::GetFolderPath('MyDocuments') + "\WindowsPowerShell\profile.ps1"

# Set the IP and hostname
$ip = "127.0.0.1"
$defaultHostname = "mylocalhost"
$hostname = Read-Host -Prompt "Enter hostname (Press Enter to use default: $defaultHostname)"

# Use default hostname if input is blank
if ([string]::IsNullOrWhiteSpace($hostname)) {
    $hostname = $defaultHostname
}

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

# Check if the source file exists
if (Test-Path $source) {
    # Copy the file
    Copy-Item -Path $source -Destination $destination
    Write-Output "File copied successfully."
}
else {
    Write-Output "Source file does not exist."

    # Prompt to create the file
    $response = Read-Host -Prompt "Source file does not exist. Do you want to create it? (Y,y / N,n)"

    if ($response -eq "Y" -or $response -eq "y") {
        # Create the file and copy the custom profile.ps1
        New-Item -ItemType File -Path $source -Force
        Copy-Item -Path $source -Destination $destination
        Write-Output "File created and copied successfully."
    }
    elseif ($response -eq "N" -or $response -eq "n") {
        Write-Output "Please create the source file manually and copy it over."
    }
    else {
        Write-Output "Invalid response. Please enter Y,y or N,n."
    }
}
