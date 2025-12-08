param(
    [string]$file_exit = "users_extraction.txt"
)

Clear-Host

Write-Host "Extracting system users and descriptions..." -ForegroundColor Cyan


$users = Get-LocalUser | Where-Object { $_.Enabled -eq $true -and $_.Name -notlike "Default*" -and $_.Name -notlike "*$" }

$resultado = @()
foreach ($users in $users) {
    $description = if ($users.Description) { $users.Description } else { "No description" }
    $resultado += "$($users.Name): $description"
}
 

$resultado | Out-File -FilePath $file_exit -Encoding UTF8

Write-Host "Result saved in: $file_exit" -ForegroundColor Green
Write-Host "First 6 lines:" -ForegroundColor Yellow
Get-Content $file_exit -Head 6
