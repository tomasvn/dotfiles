# Only elevate when not run from the orchestrator
if (-not $env:DOTFILES_FROM_FULL_INSTALL) {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

$DevToolboxHeader = @'
  _____               _______          _ _                 
 |  __ \             |__   __|        | | |                
 | |  | | _____   __    | | ___   ___ | | |__   _____  __  
 | |  | |/ _ \ \ / /    | |/ _ \ / _ \| | '_ \ / _ \ \/ /  
 | |__| |  __/\ V /     | | (_) | (_) | | |_) | (_) >  <   
 |_____/ \___| \_/      |_|\___/ \___/|_|_.__/ \___/_/\_\  
                                                          
'@

Write-Host $DevToolboxHeader -ForegroundColor Cyan
Write-Host "uninstall.ps1 starting..." -ForegroundColor Green

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
            if ($i -eq $index) { Write-Host "> $marker $item" -ForegroundColor Yellow } else { Write-Host "  $marker $item" }
        }

        $key = [System.Console]::ReadKey($true)
        switch ($key.Key) {
            'UpArrow'   { if ($visible.Count -gt 0 -and $index -gt 0) { $index-- } }
            'DownArrow' { if ($visible.Count -gt 0 -and $index -lt $visible.Count - 1) { $index++ } }
            'Spacebar'  {
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

# Gather installed Chocolatey packages reliably
try {
    $installedPackages = choco list --local-only --no-color 2>$null |
        ForEach-Object { ($_ -split '\|')[0].Trim() } |
        Where-Object { $_ } |
        Sort-Object -Unique
} catch {
    Write-Warning "Failed to query installed packages: $_"
    return
}

if (-not $installedPackages -or $installedPackages.Count -eq 0) {
    Write-Host "No Chocolatey packages found to uninstall." -ForegroundColor Yellow
    return
}

Write-Host "Found packages:" -ForegroundColor Cyan
$installedPackages | ForEach-Object { Write-Host " - $_" }

# Prompt for mode
$mode = Read-Host -Prompt "Uninstall mode - (y) all, (i) interactive select, (n) none"

switch ($mode.ToLower()) {
    'y' {
        $selected = $installedPackages
    }
    'i' {
        $selected = Select-FromList -items $installedPackages
    }
    default {
        Write-Host "Aborting uninstallation." -ForegroundColor Yellow
        return
    }
}

if (-not $selected -or $selected.Count -eq 0) {
    Write-Host "No packages selected. Exiting." -ForegroundColor Yellow
    return
}

foreach ($pkg in $selected) {
    try {
        Write-Host "Uninstalling $pkg..." -ForegroundColor Green
        choco uninstall -y $pkg 2>&1 | ForEach-Object { Write-Host $_ }
        Write-Host "Finished: $pkg" -ForegroundColor Cyan
    } catch {
        Write-Warning "Failed to uninstall $pkg: $_"
    }
}

Write-Host "Uninstall process complete." -ForegroundColor Green