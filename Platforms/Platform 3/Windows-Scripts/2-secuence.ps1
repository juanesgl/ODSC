Clear-Host
$path = "C:\UNIVERSIDAD-GIT\Proyectos\ODSC\Platforms\Platform 3\Windows-Scripts\Poem\poem.txt"
$lineCount = (Get-Content $path).Length
Write-Host "The number of lines on the poem is: $lineCount"