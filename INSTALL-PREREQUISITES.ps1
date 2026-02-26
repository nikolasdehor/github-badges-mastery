# 🏆 INSTALADOR DE PRÉ-REQUISITOS CROSS-PLATFORM
# Instala automaticamente todas as dependências necessárias

param(
    [switch]$Force,
    [switch]$Quiet
)

# Configurações
$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

# Detectar SO
$IsWindows = $PSVersionTable.PSVersion.Major -ge 6 -and $IsWindows -or $PSVersionTable.PSVersion.Major -lt 6
$IsLinux = $PSVersionTable.Platform -eq "Unix" -and -not $IsMacOS
$IsMacOS = $PSVersionTable.Platform -eq "Unix" -and [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::OSX)

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    
    $colors = @{
        "Red" = 31
        "Green" = 32
        "Yellow" = 33
        "Blue" = 34
        "Magenta" = 35
        "Cyan" = 36
        "White" = 37
    }
    
    if ($colors.ContainsKey($Color)) {
        Write-Host "`e[1;$($colors[$Color])m$Message`e[0m"
    } else {
        Write-Host $Message
    }
}

function Test-Command {
    param([string]$Command)
    
    try {
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    }
    catch {
        return $false
    }
}

function Install-WindowsPrerequisites {
    Write-ColorOutput "🪟 Instalando pré-requisitos para Windows..." "Cyan"
    
    # Verificar se winget está disponível
    if (-not (Test-Command "winget")) {
        Write-ColorOutput "❌ Winget não encontrado! Instalando..." "Red"
        
        # Tentar instalar winget
        try {
            $wingetUrl = "https://aka.ms/getwinget"
            Write-ColorOutput "📥 Baixando winget..." "Yellow"
            Invoke-WebRequest -Uri $wingetUrl -OutFile "$env:TEMP\winget.msixbundle"
            Add-AppxPackage -Path "$env:TEMP\winget.msixbundle"
            Write-ColorOutput "✅ Winget instalado!" "Green"
        }
        catch {
            Write-ColorOutput "❌ Falha ao instalar winget. Instale manualmente." "Red"
            Write-ColorOutput "💡 Visite: https://github.com/microsoft/winget-cli/releases" "Yellow"
            return $false
        }
    }
    
    # Instalar Git
    if (-not (Test-Command "git")) {
        Write-ColorOutput "📦 Instalando Git..." "Yellow"
        winget install Git.Git --silent --accept-package-agreements --accept-source-agreements
        Write-ColorOutput "✅ Git instalado!" "Green"
    } else {
        Write-ColorOutput "✅ Git já está instalado" "Green"
    }
    
    # Instalar GitHub CLI
    if (-not (Test-Command "gh")) {
        Write-ColorOutput "📦 Instalando GitHub CLI..." "Yellow"
        winget install GitHub.cli --silent --accept-package-agreements --accept-source-agreements
        Write-ColorOutput "✅ GitHub CLI instalado!" "Green"
    } else {
        Write-ColorOutput "✅ GitHub CLI já está instalado" "Green"
    }
    
    # Instalar Node.js
    if (-not (Test-Command "node")) {
        Write-ColorOutput "📦 Instalando Node.js..." "Yellow"
        winget install OpenJS.NodeJS --silent --accept-package-agreements --accept-source-agreements
        Write-ColorOutput "✅ Node.js instalado!" "Green"
    } else {
        Write-ColorOutput "✅ Node.js já está instalado" "Green"
    }
    
    return $true
}

function Install-Winget {
    Write-ColorOutput "📦 Instalando Winget..." "Yellow"
    try {
        Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
        Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
        Remove-Item Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
        Write-Host "✅ Winget instalado com sucesso!" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Falha ao instalar Winget. Instale manualmente via Microsoft Store." -ForegroundColor Red
        Write-Host "🔗 https://www.microsoft.com/store/productId/9NBLGGH4NNS1" -ForegroundColor Cyan
        Read-Host "Pressione Enter para continuar mesmo assim"
    }
}

Write-Host ""
Write-Host "📦 INSTALANDO FERRAMENTAS NECESSÁRIAS..." -ForegroundColor Yellow
Write-Host ""

# 1. GitHub CLI
Write-Host "1️⃣ Instalando GitHub CLI..." -ForegroundColor Cyan
try {
    winget install --id GitHub.cli --silent --accept-package-agreements --accept-source-agreements
    Write-Host "✅ GitHub CLI instalado!" -ForegroundColor Green
}
catch {
    Write-Host "⚠️ Falha no winget, tentando chocolatey..." -ForegroundColor Yellow
    try {
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        }
        choco install gh -y
        Write-Host "✅ GitHub CLI instalado via Chocolatey!" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Falha ao instalar GitHub CLI automaticamente" -ForegroundColor Red
        Write-Host "📝 Instale manualmente:" -ForegroundColor Yellow
        Write-Host "   1. Baixe de: https://cli.github.com/" -ForegroundColor White
        Write-Host "   2. Ou use: winget install GitHub.cli" -ForegroundColor White
    }
}

# 2. Git
Write-Host ""
Write-Host "2️⃣ Verificando Git..." -ForegroundColor Cyan
try {
    git --version | Out-Null
    Write-Host "✅ Git já está instalado!" -ForegroundColor Green
}
catch {
    Write-Host "📦 Instalando Git..." -ForegroundColor Yellow
    try {
        winget install --id Git.Git --silent --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Git instalado!" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Falha ao instalar Git automaticamente" -ForegroundColor Red
        Write-Host "📝 Instale manualmente de: https://git-scm.com/" -ForegroundColor Yellow
    }
}

# 3. Node.js (opcional, para monitoring avançado)
Write-Host ""
Write-Host "3️⃣ Verificando Node.js..." -ForegroundColor Cyan
try {
    node --version | Out-Null
    Write-Host "✅ Node.js já está instalado!" -ForegroundColor Green
}
catch {
    Write-Host "📦 Instalando Node.js..." -ForegroundColor Yellow
    try {
        winget install --id OpenJS.NodeJS --silent --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Node.js instalado!" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Node.js não foi instalado (opcional)" -ForegroundColor Yellow
        Write-Host "💡 Para monitoring avançado, instale de: https://nodejs.org/" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "🔄 ATUALIZANDO VARIÁVEIS DE AMBIENTE..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host "✅ INSTALAÇÃO CONCLUÍDA!" -ForegroundColor Green
Write-Host "========================" -ForegroundColor Green
Write-Host ""
Write-Host "📋 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "1. Feche e reabra o PowerShell" -ForegroundColor White
Write-Host "2. Execute: gh auth login" -ForegroundColor White
Write-Host "3. Execute: .\EXECUTE-BADGES-MASTER.bat" -ForegroundColor White
Write-Host ""
Write-Host "🎯 COMANDOS PARA TESTAR:" -ForegroundColor Cyan
Write-Host "gh --version" -ForegroundColor White
Write-Host "git --version" -ForegroundColor White
Write-Host "node --version" -ForegroundColor White
Write-Host ""

Read-Host "Pressione Enter para sair"