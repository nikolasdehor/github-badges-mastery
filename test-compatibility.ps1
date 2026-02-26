# Teste de compatibilidade PowerShell 5.1 vs 7+
# Este script verifica se as sintaxes estão compatíveis

Write-Host "🧪 TESTE DE COMPATIBILIDADE POWERSHELL" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Testar detecção de SO
Write-Host "Versão PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow

if ($PSVersionTable.PSVersion.Major -ge 6) {
    Write-Host "✅ PowerShell 7+ detectado" -ForegroundColor Green
    $IsWindowsOS = $IsWindows
    $IsLinuxOS = $IsLinux  
    $IsMacOSOS = $IsMacOS
} else {
    Write-Host "✅ PowerShell 5.1 detectado" -ForegroundColor Green
    $IsWindowsOS = $true
    $IsLinuxOS = $false
    $IsMacOSOS = $false
}

Write-Host "SO detectado: Windows=$IsWindowsOS, Linux=$IsLinuxOS, macOS=$IsMacOSOS" -ForegroundColor Cyan

# Testar comando de commit (sem executar)
$testCommand = 'git add .; git commit -m "🏆 badge automation`n`nCo-authored-by: GitHub Copilot <copilot@github.com>"; git push'
Write-Host "✅ Comando de teste criado sem erros" -ForegroundColor Green

# Testar array de comandos
$commands = @(
    @{ Name = "TESTE"; Command = "echo 'teste'" }
)
Write-Host "✅ Array de comandos criado sem erros" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 TESTE CONCLUÍDO - SINTAXE COMPATÍVEL!" -ForegroundColor Green