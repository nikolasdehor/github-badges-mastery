# Teste rapido da funcao Find-GitHubCLI
Write-Host "Testando Find-GitHubCLI..." -ForegroundColor Cyan

# Copiar a funcao corrigida para teste
function Find-GitHubCLI {
    # Procurar em locais de instalacao (ordem de prioridade)
    # Nao usar PATH pois pode estar quebrado
    $searchPaths = @(
        # Instalacao padrao (mais comum)
        "${env:ProgramFiles}\GitHub CLI\gh.exe",
        "${env:ProgramFiles(x86)}\GitHub CLI\gh.exe",
        # Winget installations
        "${env:LOCALAPPDATA}\Microsoft\WindowsApps\gh.exe",
        "${env:USERPROFILE}\AppData\Local\Microsoft\WindowsApps\gh.exe",
        # Chocolatey installations
        "${env:ProgramData}\chocolatey\bin\gh.exe",
        # Outras localizacoes
        "${env:LOCALAPPDATA}\GitHubCLI\gh.exe",
        "${env:APPDATA}\GitHub CLI\gh.exe"
    )
    
    # Verificar WindowsApps directory (mais abrangente)
    try {
        $wingetApps = "${env:LOCALAPPDATA}\Microsoft\WindowsApps"
        if (Test-Path $wingetApps) {
            $ghFiles = Get-ChildItem $wingetApps -Filter "gh.exe" -Recurse -ErrorAction SilentlyContinue
            foreach ($file in $ghFiles) {
                $searchPaths += $file.FullName
            }
        }
    } catch {}
    
    # Testar cada caminho
    foreach ($path in $searchPaths) {
        Write-Host "Testando: $path" -ForegroundColor Gray
        if (Test-Path $path) {
            try {
                # Testar se o executavel funciona
                $null = & $path --version 2>$null
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "ENCONTRADO: $path" -ForegroundColor Green
                    return $path
                }
            } catch {}
        }
    }
    
    Write-Host "Nao encontrado em nenhum local" -ForegroundColor Red
    return $null
}

$result = Find-GitHubCLI
Write-Host ""
Write-Host "RESULTADO FINAL: $result" -ForegroundColor Yellow

if ($result) {
    Write-Host ""
    Write-Host "Testando autenticacao com caminho correto..." -ForegroundColor Cyan
    & $result auth status
} else {
    Write-Host "GitHub CLI nao foi encontrado!" -ForegroundColor Red
}