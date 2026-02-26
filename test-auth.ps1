# Teste de autenticação GitHub CLI
Write-Host "Testando GitHub CLI Authentication" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$ghPath = "C:\Program Files\GitHub CLI\gh.exe"

Write-Host "Caminho do GitHub CLI: $ghPath" -ForegroundColor Yellow

if (Test-Path $ghPath) {
    Write-Host "Executavel encontrado!" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "Testando versao..." -ForegroundColor Cyan
    & $ghPath --version
    
    Write-Host ""
    Write-Host "Testando status de autenticacao..." -ForegroundColor Cyan
    & $ghPath auth status
    
    Write-Host ""
    Write-Host "Iniciando processo de login..." -ForegroundColor Yellow
    Write-Host "Voce sera redirecionado para o browser" -ForegroundColor Cyan
    
    & $ghPath auth login --web
    
} else {
    Write-Host "GitHub CLI nao encontrado em: $ghPath" -ForegroundColor Red
}

Write-Host ""
Write-Host "Teste concluido!" -ForegroundColor Green