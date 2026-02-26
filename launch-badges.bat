@echo off
chcp 65001 >nul
REM 🏆 GitHub Badges Mastery - Windows Launcher
REM Detecta e executa a versão apropriada

echo.
echo 🏆 GITHUB BADGES MASTERY - WINDOWS LAUNCHER
echo ==========================================
echo.

REM Procurar PowerShell 7+ em locais comuns
set "PWSH_PATH="

REM Tentar PATH primeiro
pwsh -Command "Write-Host '✅ PowerShell 7+ encontrado no PATH'" 2>nul
if %errorlevel% equ 0 (
    set "PWSH_PATH=pwsh"
    goto :foundpwsh
)

REM Tentar locais comuns de instalação
if exist "%ProgramFiles%\PowerShell\7\pwsh.exe" (
    set "PWSH_PATH=%ProgramFiles%\PowerShell\7\pwsh.exe"
    goto :foundpwsh
)

if exist "%ProgramFiles(x86)%\PowerShell\7\pwsh.exe" (
    set "PWSH_PATH=%ProgramFiles(x86)%\PowerShell\7\pwsh.exe"
    goto :foundpwsh
)

REM Verificar no Windows Apps
for /d %%D in ("%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.PowerShell*") do (
    if exist "%%D\pwsh.exe" (
        set "PWSH_PATH=%%D\pwsh.exe"
        goto :foundpwsh
    )
)

goto :try51

:foundpwsh
echo ✅ PowerShell 7+ encontrado
echo 🚀 Executando com PowerShell 7...
echo.
"%PWSH_PATH%" -File "EXECUTE-BADGES-UNIVERSAL.ps1" %*
goto :end

:try51
REM Verificar se PowerShell 5.1 está disponível
powershell -Command "Write-Host '✅ PowerShell 5.1 encontrado'" 2>nul
if %errorlevel% equ 0 (
    echo ✅ PowerShell 5.1 encontrado
    echo ⚠️ Usando PowerShell 5.1 (recomenda-se PowerShell 7)
    echo 💡 Para melhor experiência, instale PowerShell 7: winget install Microsoft.PowerShell
    echo.
    powershell -ExecutionPolicy Bypass -File "EXECUTE-BADGES-UNIVERSAL.ps1" %*
    goto :end
)

REM PowerShell não encontrado
echo ❌ PowerShell não encontrado!
echo.
echo 💡 Soluções:
echo   1. Instale PowerShell 7: winget install Microsoft.PowerShell
echo   2. Ou execute manualmente: pwsh EXECUTE-BADGES-UNIVERSAL.ps1
echo   3. Ou use o script bash: bash launch-badges.sh
echo.
pause
exit /b 1

:end
echo.
echo 🎉 Launcher concluído!
if not "%1"=="--no-pause" pause