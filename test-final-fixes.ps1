# Teste das correções do MASTER-BADGE-AUTOMATION.ps1
Write-Host "🧪 TESTANDO CORREÇÕES DO SISTEMA" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# 1. Testar configuração Git
Write-Host ""
Write-Host "1. Testando configuração Git..." -ForegroundColor Yellow
$gitUser = git config user.name 2>$null
$gitEmail = git config user.email 2>$null

if (-not $gitUser -or -not $gitEmail) {
    Write-Host "⚙️ Configurando Git..." -ForegroundColor Yellow
    git config user.name "nikolasdehorcast"
    git config user.email "nikolasdehorcast@users.noreply.github.com"
    Write-Host "✅ Git configurado!" -ForegroundColor Green
} else {
    Write-Host "✅ Git já configurado: $gitUser <$gitEmail>" -ForegroundColor Green
}

# 2. Testar GitHub CLI
Write-Host ""
Write-Host "2. Testando GitHub CLI..." -ForegroundColor Yellow
$ghPath = "C:\Program Files\GitHub CLI\gh.exe"
if (Test-Path $ghPath) {
    Write-Host "✅ GitHub CLI encontrado: $ghPath" -ForegroundColor Green
    
    # Testar comando de autenticação
    $authStatus = & $ghPath auth status 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ GitHub CLI autenticado" -ForegroundColor Green
    } else {
        Write-Host "❌ GitHub CLI não autenticado" -ForegroundColor Red
    }
} else {
    Write-Host "❌ GitHub CLI não encontrado" -ForegroundColor Red
}

# 3. Verificar status do repositório
Write-Host ""
Write-Host "3. Verificando repositório..." -ForegroundColor Yellow
$repoStatus = git status --porcelain 2>$null
if ($repoStatus) {
    Write-Host "⚠️ Há alterações não commitadas:" -ForegroundColor Yellow
    Write-Host $repoStatus -ForegroundColor Gray
} else {
    Write-Host "✅ Repositório limpo" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎯 TESTE CONCLUÍDO!" -ForegroundColor Green
Write-Host "Agora execute: .\launch-badges.bat" -ForegroundColor Cyan