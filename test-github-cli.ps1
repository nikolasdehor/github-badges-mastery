# TESTE DE GitHub CLI - DIAGNOSTICO COMPLETO

Write-Host "DIAGNOSTICO DO GITHUB CLI" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

# Função Find-GitHubCLI (cópia da principal)
function Find-GitHubCLI {
    # Primeiro tentar PATH
    try {
        $null = Get-Command "gh" -ErrorAction SilentlyContinue
        if ($?) {
            Write-Host "GitHub CLI encontrado no PATH" -ForegroundColor Green
            return "gh"
        }
    } catch {}
    
    Write-Host "GitHub CLI nao esta no PATH, procurando..." -ForegroundColor Yellow
    
    # Procurar em locais comuns de instalação
    $commonPaths = @(
        "${env:ProgramFiles}\GitHub CLI\gh.exe",
        "${env:ProgramFiles(x86)}\GitHub CLI\gh.exe",
        "${env:LOCALAPPDATA}\GitHubCLI\gh.exe",
        "${env:APPDATA}\GitHub CLI\gh.exe"
    )
    
    Write-Host "Verificando locais comuns:" -ForegroundColor Cyan
    foreach ($path in $commonPaths) {
        Write-Host "   Tentando: $path" -ForegroundColor Gray
        if (Test-Path $path) {
            Write-Host "GitHub CLI encontrado em: $path" -ForegroundColor Green
            return $path
        }
    }
    
    # Verificar Windows Apps (winget installations)
    Write-Host "Verificando WindowsApps:" -ForegroundColor Cyan
    try {
        $wingetPaths = Get-ChildItem "${env:LOCALAPPDATA}\Microsoft\WindowsApps" -Filter "gh.exe" -ErrorAction SilentlyContinue
        if ($wingetPaths) {
            foreach ($path in $wingetPaths) {
                Write-Host "GitHub CLI encontrado via WindowsApps: $($path.FullName)" -ForegroundColor Green
                return $path.FullName
            }
        }
    } catch {
        Write-Host "Erro ao verificar WindowsApps: $_" -ForegroundColor Yellow
    }
    
    Write-Host "GitHub CLI nao encontrado em nenhum local" -ForegroundColor Red
    return $null
}

# Executar diagnóstico
$ghPath = Find-GitHubCLI

if ($ghPath) {
    Write-Host ""
    Write-Host "TESTANDO FUNCIONALIDADE:" -ForegroundColor Cyan
    
    try {
        Write-Host "Comando: $ghPath --version" -ForegroundColor Gray
        $version = & $ghPath --version 2>&1
        Write-Host "Versao: $version" -ForegroundColor Green
        
        Write-Host ""
        Write-Host "Comando: $ghPath auth status" -ForegroundColor Gray
        $authStatus = & $ghPath auth status 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Autenticado com sucesso" -ForegroundColor Green
            Write-Host "Status: $authStatus" -ForegroundColor Gray
        } else {
            Write-Host "Nao autenticado" -ForegroundColor Yellow
            Write-Host "Status: $authStatus" -ForegroundColor Gray
        }
        
    } catch {
        Write-Host "Erro ao testar GitHub CLI: $_" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "CAMINHO FINAL PARA USO:" -ForegroundColor Green
    Write-Host "   $ghPath" -ForegroundColor White
    
} else {
    Write-Host ""
    Write-Host "SOLUCOES:" -ForegroundColor Yellow
    Write-Host "   1. Instalar via winget: winget install GitHub.cli" -ForegroundColor White
    Write-Host "   2. Baixar de: https://github.com/cli/cli/releases" -ForegroundColor White
    Write-Host "   3. Reiniciar terminal apos instalacao" -ForegroundColor White
}

Write-Host ""
Write-Host "Diagnostico concluido!" -ForegroundColor Cyan