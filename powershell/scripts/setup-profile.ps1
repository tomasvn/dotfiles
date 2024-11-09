# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Restart script with elevated privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$source = ".\profile.ps1"
$destination = [System.Environment]::GetFolderPath('MyDocuments') + "\WindowsPowerShell\profile.ps1"

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
