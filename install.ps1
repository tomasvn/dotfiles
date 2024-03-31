$shellScripts = ".\powershell\install-pkg-manager.ps1", ".\powershell\install-pkgs.ps1", ".\powershell\setup-localhost.ps1"

try {
    foreach ($script in $shellScripts) {
        Invoke-Expression -Command $script
    }
}
catch {
    Write-Host "Error while running script at $script $_"
}
