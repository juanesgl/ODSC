param(
    [Parameter(Mandatory = $true)]
    [string]$directory,
    [Parameter(Mandatory = $true)]
    [string]$permit
)

Clear-Host

if (-not (Test-Path -Path $directory -PathType Container)) {
    Write-Host "Error: '$directory' is not a valid directory." -ForegroundColor Red
    exit 1
}

Write-Host "Searching for files in '$directory' with permissions '$permit':" -ForegroundColor Cyan

switch ($permit) {
    "\FullControl" { $acRights = [System.Security.AccessControl.FileSystemRights]::FullControl }
    "\Read" { $acRights = [System.Security.AccessControl.FileSystemRights]::Read }
    "\Write" { $acRights = [System.Security.AccessControl.FileSystemRights]::Write }
    "\Execute" { $acRights = [System.Security.AccessControl.FileSystemRights]::ExecuteFile }
    default { 
        Write-Host "Unrecognized permission. Use: \FullControl, \Read, \Write, \Execute" -ForegroundColor Red
        exit 1
    }
}


Get-ChildItem -Path $directory -File | ForEach-Object {
    try {
        $acl = Get-Acl -Path $_.FullName
        $access = $acl.Access | Where-Object { 
            $_.FileSystemRights -band $acRights -eq $acRights -and 
            $_.AccessControlType -eq "Allow"
        }
        if ($access) {
            Write-Host "$($_.Name) - Permission: $($access.FileSystemRights)" -ForegroundColor Green
        }
    }
    catch {
        
    }
}
