function Clean {
    Clear-Host
}

do {
    Clean
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "        PRINCIPAL MENU" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "1) Hello World"
    Write-Host "2) Count poem lines"
    Write-Host "3) Search word in file"
    Write-Host "4) Extract system users"
    Write-Host "5) Search files by permission"
    Write-Host "6) Exit"
    Write-Host "================================" -ForegroundColor Cyan
    $opcion = Read-Host "Choose an option (1-6)"

    switch ($opcion) {
        "1" { 
            Clean
            & ".\1-hello.ps1"
            Read-Host "Press Enter to continue"
        }
        "2" { 
            Clean
            & ".\2-secuence.ps1"
            Read-Host "Press Enter to continue"
        }
        "3" { 
            Clean
            $palabra = Read-Host "Enter word to search"
            $archivo = Read-Host "Enter file path"
            & ".\3-buscar_palabra.ps1" $palabra $archivo
            Read-Host "Press Enter to continue"
        }
        "4" { 
            Clean
            & ".\4-extraer_usuarios.ps1"
            Read-Host "Press Enter to continue"
        }
        "5" { 
            Clean
            $directorio = Read-Host "Enter directory"
            $permiso = Read-Host "Enter permission (\FullControl, \Read, etc.)"
            & ".\5-buscar_archivos.ps1" $directorio $permiso
            Read-Host "Press Enter to continue"
        }
        "6" { 
            Write-Host "Goodbye!" -ForegroundColor Green
            break 
        }
        default { 
            Write-Host "Invalid option." -ForegroundColor Red
            Read-Host "Press Enter"
        }
    }
} while ($opcion -ne "6")
