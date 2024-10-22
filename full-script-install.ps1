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

$packages | ForEach-Object {
    # Run command choco install
    # with flag -y (--yes)
    # $_ is current item in loop
    choco install -y $_
    $installPath = (Get-Command $_).Source
    Write-Host "Package $_ installed at: $installPath"
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
