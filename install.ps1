$shellScripts = ".\powershell\setup-pkg-manager.ps1", ".\powershell\setup-pkgs.ps1", ".\powershell\setup-localhost.ps1"

try {
    foreach ($script in $shellScripts) {
        if ($script -like "*setup*") {
            Invoke-Expression -Command $script
        }
    }
}
catch {
    Write-Host "Error while running script at $script $_"
}
