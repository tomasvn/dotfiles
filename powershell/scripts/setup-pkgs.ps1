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

$packages | ForEach-Object {
    # Run command choco install
    # with flag -y (--yes)
    # $_ is current item in loop
    choco install -y $_
    $installPath = (Get-Command $_).Source
    Write-Host "Package $_ installed at: $installPath"
}