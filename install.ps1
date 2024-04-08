$path = ".\powershell\scripts"

$shellScripts = @(
    "$path\setup-profile.ps1",
    "$path\setup-pkg-manager.ps1",
    "$path\setup-pkgs.ps1",
    "$path\setup-git.ps1",
    "$path\setup-localhost.ps1"
)

try {
    foreach ($script in $shellScripts) {
        if ($script -like "*setup*") {
            Invoke-Expression -Command $script
            Write-Host "Waiting for scripts to install..."
            Start-Sleep -Seconds 5
        }
    }
}
catch {
    Write-Host "Error while running script at $script $_"
}
