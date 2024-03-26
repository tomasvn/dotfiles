# Add packages from https://community.chocolatey.org/packages
# Add only verified packages as the code below will install it
# without user confirm
$Packages = 'googlechrome', 'git', 'vscode', 'spotify'

$Packages | ForEach-Object {
    # Run command choco install
    # with flag -y (--yes)
    # $_ is current item in loop
    choco install -y $_
    $installPath = (Get-Command $_).Source
    Write-Host "Package $_ installed at: $installPath"
}