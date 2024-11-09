# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Restart script with elevated privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Run PowerShell as Administrator
# Set the Hosts file path
$hostsPath = "$env:windir\System32\drivers\etc\hosts"

# Set the IP and default hostname
$ip = "127.0.0.1"
$defaultHostname = "mylocalhost"

# Prompt for the hostname
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
} else {
    Write-Host "Entry already exists: $entry"
}
