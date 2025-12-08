param(
    [Parameter(Mandatory=$true)]
    [string]$name,
    [Parameter(Mandatory=$true)]
    [string]$directory
)

Clear-Host

$ruta_completa = Join-Path $directory $name

if (-not (Test-Path $directory -PathType Container)) {
    Write-Host "Error: '$directory' not a valid directory." -ForegroundColor Red
    exit 1
}

Write-Host "Verifying '$name' in '$directory':" -ForegroundColor Cyan

if (Test-Path $ruta_completa) {
    $item = Get-Item $ruta_completa
    switch ($item.PSIsContainer) {
        $false { Write-Host "It is a regular FILE" -ForegroundColor Green }
        $true  { Write-Host "It is a SUBdirectory" -ForegroundColor Green }
    }
    Get-Item $ruta_completa | Format-List
} else {
    Write-Host "Does not exist in the specified directory" -ForegroundColor Red
}
