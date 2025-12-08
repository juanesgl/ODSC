param(
    [Parameter(Mandatory = $true)]
    [string]$word,
    [Parameter(Mandatory = $true)]
    [string]$file
)

Clear-Host

if (-not (Test-Path -Path $file -PathType Leaf)) {
    Write-Host "The file '$file' does not exist."
    exit 1
}


Write-Host "Searching for '$word' in '$file':"
$results = Select-String -Path $file -Pattern $word -SimpleMatch

if ($results) {
    foreach ($resultado in $results) {
        Write-Host "Found on line $($resultado.LineNumber): $($resultado.Line)"
    }
} else {
    Write-Host "The word '$word' was not found in the file."
}
