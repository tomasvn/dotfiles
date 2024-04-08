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
}