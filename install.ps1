$DevToolboxHeader = @'
  _____               _______          _ _                 
 |  __ \             |__   __|        | | |                
 | |  | | _____   __    | | ___   ___ | | |__   _____  __  
 | |  | |/ _ \ \ / /    | |/ _ \ / _ \| | '_ \ / _ \ \/ /  
 | |__| |  __/\ V /     | | (_) | (_) | | |_) | (_) >  <   
 |_____/ \___| \_/      |_|\___/ \___/|_|_.__/ \___/_/\_\  
                                                          
'@

Write-Host $DevToolboxHeader -ForegroundColor Cyan
Write-Host "install.ps1 starting..." -ForegroundColor Green

# packages list
$packages = @(
    'googlechrome', 'git', 'vscode', 'spotify', 'powertoys', 'devtoys',
    'powershell-core', 'visualstudio2022enterprise', 'lazygit',
    'dotnet-6.0-aspnetruntime', 'cmder', 'poshgit'
)

function InstallPackage {
    param([string]$package)
    Write-Host "Installing $package..."
    choco install -y $package
    $command = Get-Command $package -ErrorAction SilentlyContinue
    if ($command) { Write-Host "Package $package installed at: $($command.Source)" }
    else { Write-Host "Package $package installed, but the command was not found." }
}

function InstallAllPackages {
    param([array]$packages)
    foreach ($package in $packages) { InstallPackage -package $package }
}

function Select-FromList {
    param([string[]]$items)

    $selected = New-Object System.Collections.Generic.List[string]
    $index = 0
    $filter = ''
    $done = $false

    while (-not $done) {
        Clear-Host
        Write-Host "Use Up/Down to move, Space to toggle, A=all, I=invert, F=filter, Enter=confirm, Q=quit"
        if ($filter) { Write-Host "Filter: $filter" -ForegroundColor Cyan }

        $visible = if ($filter) { $items | Where-Object { $_ -match [Regex]::Escape($filter) } } else { $items }

        if ($visible.Count -eq 0) {
            Write-Host "`nNo items match the filter. Press F to change filter, Q to quit." -ForegroundColor Red
        }

        if ($visible.Count -gt 0) {
            if ($index -ge $visible.Count) { $index = $visible.Count - 1 }
            if ($index -lt 0) { $index = 0 }
        } else { $index = 0 }

        for ($i = 0; $i -lt $visible.Count; $i++) {
            $item = $visible[$i]
            $marker = if ($selected.Contains($item)) { '[x]' } else { '[ ]' }
            if ($i -eq $index) { Write-Host "> $marker $item" -ForegroundColor Yellow }
            else { Write-Host "  $marker $item" }
        }

        $key = [System.Console]::ReadKey($true)

        switch ($key.Key) {
            'UpArrow'    { if ($visible.Count -gt 0 -and $index -gt 0) { $index-- } }
            'DownArrow'  { if ($visible.Count -gt 0 -and $index -lt $visible.Count - 1) { $index++ } }
            'Spacebar'   {
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

    return , $selected.ToArray()
}

$responseAll = Read-Host -Prompt "Do you want to install all packages? (y/n)"
if ($responseAll -eq 'y') {
    InstallAllPackages -packages $packages
}
else {
    $selected = Select-FromList -items $packages
    if (-not $selected -or $selected.Count -eq 0) {
        Write-Host "No packages selected. Exiting."
    }
    else {
        foreach ($p in $selected) { InstallPackage -package $p }
    }
}