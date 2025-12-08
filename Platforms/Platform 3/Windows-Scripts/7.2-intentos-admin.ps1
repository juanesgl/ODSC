Clear-Host

$logName   = "Security"
$adminName = "Administrator"

Write-Host "Searching for failed logon attempts to $adminName..." -ForegroundColor Cyan

$failedEvents = Get-WinEvent -FilterHashtable @{ LogName = $logName; ID = 4625 } -MaxEvents 1000 -ErrorAction SilentlyContinue |
    Where-Object { $_.Message -match $adminName -or $_.Message -match $env:COMPUTERNAME }


$counter = 0
Write-Host "==============================" -ForegroundColor Yellow
Write-Host "Failed logon attempts to $adminName" -ForegroundColor Yellow

Write-Host "==============================" -ForegroundColor Yellow

foreach ($ev in $failedEvents) {
    $time = $ev.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "[$time] $($ev.Id) - $($ev.Message.Split('`n')[0])" -ForegroundColor Red
    $counter++
}


Write-Host "==============================" -ForegroundColor Yellow
Write-Host "TOTAL failed attempts: $counter" -ForegroundColor Yellow
Write-Host "==============================" -ForegroundColor Yellow
