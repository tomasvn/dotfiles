$DevToolboxHeader = @'
  _____               _______          _ _                 
 |  __ \             |__   __|        | | |                
 | |  | | _____   __    | | ___   ___ | | |__   _____  __  
 | |  | |/ _ \ \ / /    | |/ _ \ / _ \| | '_ \ / _ \ \/ /  
 | |__| |  __/\ V /     | | (_) | (_) | | |_) | (_) >  <   
 |_____/ \___| \_/      |_|\___/ \___/|_|_.__/ \___/_/\_\  
                                                          
'@

Write-Host $DevToolboxHeader -ForegroundColor Cyan

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$repoRoot = Split-Path -Parent $PSCommandPath
$scriptsDir = Join-Path $repoRoot 'powershell\scripts'

$shellScripts = @(
    'setup-pkg-manager.ps1',
    'setup-pkgs.ps1',
    'setup-pws.ps1',
    'setup-localhost.ps1',
    'setup-profile.ps1'
) | ForEach-Object { Join-Path $scriptsDir $_ }

foreach ($script in $shellScripts) {
    if (Test-Path $script) {
        Write-Host "Running $([IO.Path]::GetFileName($script))..."
        try {
            & $script
        }
        catch {
            Write-Warning "Script failed: $script - $_"
        }
        Start-Sleep -Seconds 2
    }
    else {
        Write-Warning "Missing script: $script"
    }
}

$source = Join-Path $repoRoot 'powershell\profile.ps1'
if (Test-Path $source) {
    $loaderLine = ". '$source'"
    $targets = @(
        $PROFILE.CurrentUserAllHosts,
        $PROFILE.CurrentUserCurrentHost,
        (Join-Path (Join-Path $HOME 'Documents') 'PowerShell\profile.ps1')
    ) | Select-Object -Unique

    foreach ($target in $targets) {
        if (-not $target) { continue }

        $targetDir = Split-Path $target -Parent
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        if (Test-Path $target) {
            $bak = "$target.bak"
            Copy-Item -Path $target -Destination $bak -Force
            Write-Host "Backed up existing profile to $bak"

            $existing = Get-Content $target -Raw -ErrorAction SilentlyContinue
            if ($existing -and ($existing -match [regex]::Escape($loaderLine))) {
                Write-Host "Loader already present in $target - skipping"
                continue
            }
        }

        $content = "# Autoload repo profile`n$loaderLine`n"
        Set-Content -Path $target -Value $content -Force
        Write-Host "Wrote loader to $target"
    }

    try {
        $currentPolicy = Get-ExecutionPolicy -Scope CurrentUser -ErrorAction Stop
        if ($currentPolicy -in @('Undefined', 'Restricted')) {
            Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
            Write-Host 'Set CurrentUser execution policy to RemoteSigned'
        }
    }
    catch {
        Write-Warning "Could not read/set execution policy: $_"
    }
}

$packages = @(
    'googlechrome',
    'git',
    'vscode',
    'spotify',
    'powertoys',
    'devtoys',
    'pwsh',
    'lazygit',
    'cmder',
    'posh-git'
)

function Test-ScoopPackageInstalled {
    param([string]$package)

    try {
        $installedPackages = @(scoop list 2>$null | ForEach-Object { ($_ -split '\\s+')[0].Trim() } | Where-Object { $_ })
        return $installedPackages -contains $package
    }
    catch {
        return $false
    }
}

function InstallPackage {
    param([string]$package)

    Write-Host "Installing $package..."
    scoop install $package

    if (Test-ScoopPackageInstalled -package $package) {
        Write-Host "Package $package installed."
    }
    else {
        Write-Host "Package $package installed, but Scoop did not report it in the package list."
    }
}

function InstallAllPackages {
    param([array]$packages)

    foreach ($package in $packages) {
        InstallPackage -package $package
    }
}

function Select-FromList {
    param([string[]]$items)

    $selected = New-Object System.Collections.Generic.List[string]
    $index = 0
    $filter = ''
    $done = $false

    while (-not $done) {
        Clear-Host
        Write-Host 'Use Up/Down to move, Space to toggle, A=all, I=invert, F=filter, Enter=confirm, Q=quit'
        if ($filter) { Write-Host "Filter: $filter" -ForegroundColor Cyan }

        $visible = if ($filter) { $items | Where-Object { $_ -match [Regex]::Escape($filter) } } else { $items }

        if ($visible.Count -eq 0) {
            Write-Host "`nNo items match the filter. Press F to change filter, Q to quit." -ForegroundColor Red
        }

        if ($visible.Count -gt 0) {
            if ($index -ge $visible.Count) { $index = $visible.Count - 1 }
            if ($index -lt 0) { $index = 0 }
        }
        else {
            $index = 0
        }

        for ($i = 0; $i -lt $visible.Count; $i++) {
            $item = $visible[$i]
            $marker = if ($selected.Contains($item)) { '[x]' } else { '[ ]' }
            if ($i -eq $index) { Write-Host "> $marker $item" -ForegroundColor Yellow }
            else { Write-Host "  $marker $item" }
        }

        $key = [System.Console]::ReadKey($true)

        switch ($key.Key) {
            'UpArrow' { if ($visible.Count -gt 0 -and $index -gt 0) { $index-- } }
            'DownArrow' { if ($visible.Count -gt 0 -and $index -lt $visible.Count - 1) { $index++ } }
            'Spacebar' {
                if ($visible.Count -gt 0) {
                    $item = $visible[$index]
                    if ($selected.Contains($item)) { $selected.Remove($item) } else { $selected.Add($item) }
                }
            }
            'A' {
                foreach ($it in $visible) { if (-not $selected.Contains($it)) { $selected.Add($it) } }
            }
            'I' {
                $new = New-Object System.Collections.Generic.List[string]
                foreach ($it in $visible) { if (-not $selected.Contains($it)) { $new.Add($it) } }
                foreach ($it in $visible) { if ($selected.Contains($it)) { $new.Add($it) } }
                $selected = $new
            }
            'F' {
                Write-Host "`nEnter filter (partial text). Empty to clear:" -NoNewline
                $filter = Read-Host
                $index = 0
            }
            'Enter' { $done = $true }
            'Q' { $selected.Clear(); $done = $true }
            'Escape' { $selected.Clear(); $done = $true }
        }
    }

    return ,$selected.ToArray()
}

$responseAll = Read-Host -Prompt 'Do you want to install all packages? (y/n)'
if ($responseAll -eq 'y') {
    InstallAllPackages -packages $packages
}
else {
    $selected = Select-FromList -items $packages
    if (-not $selected -or $selected.Count -eq 0) {
        Write-Host 'No packages selected. Exiting.'
    }
    else {
        foreach ($p in $selected) {
            InstallPackage -package $p
        }
    }
}