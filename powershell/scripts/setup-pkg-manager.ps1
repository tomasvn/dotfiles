# Check and install Scoop

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop is already installed."
}
else {
    Write-Host "Installing Scoop..."
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression (Invoke-RestMethod -Uri 'https://get.scoop.sh')
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    $desiredBuckets = @('extras', 'versions')
    $existingBuckets = @()

    try {
        $existingBuckets = @(scoop bucket list 2>$null | ForEach-Object { ($_ -split '\s+')[0].Trim() } | Where-Object { $_ })
    }
    catch {
        Write-Warning "Could not read Scoop buckets: $_"
    }

    foreach ($bucket in $desiredBuckets) {
        if ($existingBuckets -notcontains $bucket) {
            Write-Host "Adding Scoop bucket: $bucket"
            scoop bucket add $bucket
        }
    }
}
