#!/usr/bin/env pwsh
# 🏆 GITHUB BADGES MASTERY - EXECUTOR UNIVERSAL
# Funciona em Windows, Linux e macOS

param(
    [switch]$DryRun,
    [switch]$QuickMode,
    [switch]$InstallPrereqs,
    [switch]$NoInteraction
)

# Configurações
$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

# Detectar SO compatível com PowerShell 5.1 e 7+
if ($PSVersionTable.PSVersion.Major -ge 6) {
    # PowerShell 7+ - usar variáveis nativas
    $IsWindowsOS = $IsWindows
    $IsLinuxOS = $IsLinux  
    $IsMacOSOS = $IsMacOS
} else {
    # PowerShell 5.1 - detectar manualmente
    $IsWindowsOS = $true
    $IsLinuxOS = $false
    $IsMacOSOS = $false
}

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White",
        [string]$Emoji = ""
    )
    
    $colors = @{
        "Red" = 31; "Green" = 32; "Yellow" = 33; "Blue" = 34
        "Magenta" = 35; "Cyan" = 36; "White" = 37
    }
    
    $colorCode = if ($colors.ContainsKey($Color)) { $colors[$Color] } else { 37 }
    Write-Host "`e[1;${colorCode}m$Emoji $Message`e[0m"
}

function Write-Title {
    param([string]$Title)
    Write-Host ""
    Write-ColorOutput $Title "Magenta" "🏆"
    Write-ColorOutput ("=" * ($Title.Length + 3)) "Magenta"
    Write-Host ""
}

function Test-Command {
    param([string]$Command)
    try {
        $null = Get-Command $Command -ErrorAction SilentlyContinue
        return $true
    }
    catch {
        return $false
    }
}

function Find-GitHubCLI {
    # Procurar em locais de instalação (ordem de prioridade)
    # Não usar PATH pois pode estar quebrado
    $searchPaths = @(
        # Instalação padrão (mais comum)
        "${env:ProgramFiles}\GitHub CLI\gh.exe",
        "${env:ProgramFiles(x86)}\GitHub CLI\gh.exe",
        # Winget installations
        "${env:LOCALAPPDATA}\Microsoft\WindowsApps\gh.exe",
        "${env:USERPROFILE}\AppData\Local\Microsoft\WindowsApps\gh.exe",
        # Chocolatey installations
        "${env:ProgramData}\chocolatey\bin\gh.exe",
        # Outras localizações
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
        if (Test-Path $path) {
            try {
                # Testar se o executável funciona
                $null = & $path --version 2>$null
                if ($LASTEXITCODE -eq 0) {
                    return $path
                }
            } catch {}
        }
    }
    
    return $null
}

function Test-Prerequisites {
    Write-ColorOutput "Verificando pré-requisitos..." "Cyan" "🔍"
    
    $allGood = $true
    $missing = @()
    
    # Verificar Git
    if (Test-Command "git") {
        try {
            $version = git --version 2>$null
            Write-ColorOutput "Git: $version" "Green" "✅"
        }
        catch {
            Write-ColorOutput "Git: Instalado" "Green" "✅"
        }
    } else {
        Write-ColorOutput "Git: Não encontrado" "Red" "❌"
        $allGood = $false
        $missing += "Git"
    }
    
    # Verificar GitHub CLI com busca avançada
    $global:GitHubCLIPath = Find-GitHubCLI
    if ($global:GitHubCLIPath) {
        try {
            $version = & $global:GitHubCLIPath --version 2>$null | Select-Object -First 1
            Write-ColorOutput "GitHub CLI: $version (Caminho: $global:GitHubCLIPath)" "Green" "✅"
        }
        catch {
            Write-ColorOutput "GitHub CLI: Instalado (Caminho: $global:GitHubCLIPath)" "Green" "✅"
        }
    } else {
        Write-ColorOutput "GitHub CLI: Não encontrado" "Red" "❌"
        $allGood = $false
        $missing += "GitHub CLI"
    }
    
    # Verificar Node.js (opcional)
    if (Test-Command "node") {
        try {
            $version = node --version 2>$null
            Write-ColorOutput "Node.js: $version" "Green" "✅"
        }
        catch {
            Write-ColorOutput "Node.js: Instalado" "Green" "✅"
        }
    } else {
        Write-ColorOutput "Node.js: Não encontrado (opcional)" "Yellow" "⚠️"
    }
    
    if (-not $allGood) {
        Write-Host ""
        Write-ColorOutput "Pré-requisitos em falta: $($missing -join ', ')" "Red" "❌"
        Write-ColorOutput "Execute o instalador: pwsh INSTALL-PREREQUISITES.ps1" "Yellow" "💡"
        return $false
    }
    
    return $true
}

function Test-GitHubAuth {
    # Sempre procurar o GitHub CLI para garantir caminho correto
    $global:GitHubCLIPath = Find-GitHubCLI
    
    if (-not $global:GitHubCLIPath) {
        Write-ColorOutput "GitHub CLI não encontrado" "Red" "❌"
        return $false
    }
    
    try {
        $result = & $global:GitHubCLIPath auth status 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "GitHub CLI autenticado" "Green" "✅"
            return $true
        }
    }
    catch {}
    
    Write-ColorOutput "GitHub CLI não autenticado" "Red" "❌"
    Write-ColorOutput "Execute: gh auth login" "Yellow" "💡"
    return $false
}

function Show-Menu {
    Write-Title "GITHUB BADGES MASTERY - MENU PRINCIPAL"
    
    Write-ColorOutput "Escolha uma opção:" "Cyan" "🎯"
    Write-Host ""
    Write-Host "1. 🚀 EXECUÇÃO COMPLETA (Conquista todas as badges automaticamente)"
    Write-Host "2. 🔍 VERIFICAR STATUS (Apenas mostra o progresso atual)"
    Write-Host "3. 📊 MONITOR AVANÇADO (Monitoramento detalhado)"
    Write-Host "4. 🧪 MODO TESTE (Dry run - não executa ações)"
    Write-Host "5. ⚡ COMANDOS RÁPIDOS MANUAIS"
    Write-Host "6. 🔧 INSTALAR PRÉ-REQUISITOS"
    Write-Host "7. 🔐 CONFIGURAR AUTENTICAÇÃO"
    Write-Host "8. 📚 MOSTRAR DOCUMENTAÇÃO"
    Write-Host "9. ❌ SAIR"
    Write-Host ""
}

function Execute-CompleteAutomation {
    Write-Title "EXECUTANDO AUTOMAÇÃO COMPLETA"
    
    if ($DryRun) {
        Write-ColorOutput "MODO DRY RUN ATIVADO - Nenhuma ação será executada" "Yellow" "🔍"
    }
    
    Write-ColorOutput "Executando MASTER-BADGE-AUTOMATION.ps1..." "Cyan" "🚀"
    
    if (Test-Path "MASTER-BADGE-AUTOMATION.ps1") {
        if ($DryRun) {
            & pwsh -File "MASTER-BADGE-AUTOMATION.ps1" -DryRun
        } else {
            & pwsh -File "MASTER-BADGE-AUTOMATION.ps1"
        }
    } else {
        Write-ColorOutput "Arquivo MASTER-BADGE-AUTOMATION.ps1 não encontrado!" "Red" "❌"
        return $false
    }
    
    Write-Host ""
    Write-ColorOutput "Automação completa executada!" "Green" "✅"
    Write-ColorOutput "Próximos passos:" "Yellow" "📝"
    Write-Host "  1. Habilite Discussions em: Settings → Features → Discussions"
    Write-Host "  2. Crie discussões usando templates em .github/DISCUSSION_TEMPLATE/"
    Write-Host "  3. Aguarde 2-4 horas para badges aparecerem no perfil"
    Write-Host "  4. Verifique em: https://github.com/settings/profile"
    
    return $true
}

function Execute-QuickCommands {
    Write-Title "COMANDOS RÁPIDOS MANUAIS"
    
    Write-ColorOutput "Execute os comandos abaixo em sequência:" "Cyan" "📋"
    Write-Host ""
    
    $commands = @(
        @{ Name = "PAIR EXTRAORDINAIRE"; Command = 'git add .; git commit -m "🏆 badge automation`n`nCo-authored-by: GitHub Copilot <copilot@github.com>"; git push' },
        @{ Name = "DEVOPS GURU"; Command = "gh workflow run ci.yml" },
        @{ Name = "QUICKDRAW + HEART"; Command = "gh workflow run quickdraw-issues.yml" },
        @{ Name = "YOLO"; Command = "gh workflow run yolo-merge.yml" },
        @{ Name = "PULL SHARK"; Command = "gh workflow run auto-pr-creator.yml" }
    )
    
    foreach ($cmd in $commands) {
        Write-Host ""
        Write-ColorOutput "$($cmd.Name):" "Yellow" "⚡"
        Write-Host "   $($cmd.Command)"
    }
    
    Write-Host ""
    Write-ColorOutput "GALAXY BRAIN (MANUAL):" "Yellow" "🧠"
    Write-Host "   1. Vá para: https://github.com/nikolasdehorcast/github-badges-mastery/settings"
    Write-Host "   2. Clique em 'Features' → 'Discussions' → 'Set up discussions'"
    Write-Host "   3. Crie discussões usando templates em .github/DISCUSSION_TEMPLATE/"
    
    if (-not $NoInteraction) {
        Write-Host ""
        $execute = Read-Host "Executar comandos automaticamente? (S/N)"
        if ($execute -eq "S" -or $execute -eq "s" -or $execute -eq "Y" -or $execute -eq "y") {
            Write-ColorOutput "Executando comandos..." "Cyan" "🚀"
            
            foreach ($cmd in $commands) {
                Write-ColorOutput "Executando: $($cmd.Name)..." "Yellow" "⚡"
                if ($DryRun) {
                    Write-ColorOutput "[DRY RUN] $($cmd.Command)" "Yellow" "🔍"
                } else {
                    try {
                        if ($cmd.Name -eq "PAIR EXTRAORDINAIRE") {
                            # Comando especial para commit com co-author
                            git add .
                            git commit -m "🏆 badge automation`n`nCo-authored-by: GitHub Copilot <copilot@github.com>"
                            git push
                        } elseif ($cmd.Command.StartsWith("gh ")) {
                            # Comando GitHub CLI - usar caminho completo
                            if (-not $global:GitHubCLIPath) {
                                $global:GitHubCLIPath = Find-GitHubCLI
                            }
                            if ($global:GitHubCLIPath) {
                                $ghCommand = $cmd.Command -replace "^gh ", ""
                                & $global:GitHubCLIPath $ghCommand.Split(" ")
                            } else {
                                throw "GitHub CLI não encontrado"
                            }
                        } else {
                            Invoke-Expression $cmd.Command
                        }
                        Write-ColorOutput "$($cmd.Name) executado!" "Green" "✅"
                    }
                    catch {
                        Write-ColorOutput "Erro ao executar $($cmd.Name): $_" "Red" "❌"
                    }
                }
                Start-Sleep -Seconds 2
            }
            
            Write-ColorOutput "Comandos executados! Aguarde alguns minutos e verifique o progresso." "Green" "✅"
        }
    }
}

function Show-Status {
    Write-Title "VERIFICANDO STATUS ATUAL"
    
    if (Test-Path "scripts/badge-monitor-complete.ps1") {
        & pwsh -File "scripts/badge-monitor-complete.ps1" -ShowQuickCommands
    } elseif (Test-Path "scripts/badge-monitor-advanced.js") {
        node "scripts/badge-monitor-advanced.js"
    } else {
        Write-ColorOutput "Scripts de monitoramento não encontrados" "Red" "❌"
        
        # Status básico
        Write-ColorOutput "Status básico do repositório:" "Cyan" "📊"
        
        try {
            $commits = git log --oneline --since="1 week ago" --grep="Co-authored-by" | Measure-Object
            Write-ColorOutput "Commits com co-autoria (última semana): $($commits.Count)" "White" "👥"
        } catch {}
        
        try {
            $prs = gh pr list --state merged --limit 10 --json number | ConvertFrom-Json
            Write-ColorOutput "PRs merged: $($prs.Count)" "White" "🦈"
        } catch {}
        
        try {
            $issues = gh issue list --limit 5 --json number | ConvertFrom-Json
            Write-ColorOutput "Issues abertas: $($issues.Count)" "White" "⚡"
        } catch {}
        
        try {
            $runs = gh run list --limit 5 --json status | ConvertFrom-Json
            $successful = ($runs | Where-Object { $_.status -eq "completed" }).Count
            Write-ColorOutput "Workflows executados: $successful" "White" "⚙️"
        } catch {}
    }
}

function Install-Prerequisites {
    Write-Title "INSTALANDO PRÉ-REQUISITOS"
    
    if (Test-Path "INSTALL-PREREQUISITES.ps1") {
        & pwsh -File "INSTALL-PREREQUISITES.ps1"
    } else {
        Write-ColorOutput "Script de instalação não encontrado!" "Red" "❌"
        Write-ColorOutput "Instale manualmente:" "Yellow" "💡"
        
        if ($IsWindowsOS) {
            Write-Host "  winget install Git.Git"
            Write-Host "  winget install GitHub.cli"
            Write-Host "  winget install OpenJS.NodeJS"
        } elseif ($IsLinuxOS) {
            Write-Host "  sudo apt install git gh nodejs npm  # Ubuntu/Debian"
            Write-Host "  sudo dnf install git gh nodejs npm  # Fedora"
            Write-Host "  sudo pacman -S git github-cli nodejs npm  # Arch"
        } elseif ($IsMacOSOS) {
            Write-Host "  brew install git gh node"
        }
    }
}

function Setup-Authentication {
    Write-Title "CONFIGURANDO AUTENTICAÇÃO GITHUB"
    
    # Sempre procurar o GitHub CLI para garantir caminho correto
    $global:GitHubCLIPath = Find-GitHubCLI
    
    if (-not $global:GitHubCLIPath) {
        Write-ColorOutput "GitHub CLI não encontrado!" "Red" "❌"
        Write-ColorOutput "Instale primeiro: winget install GitHub.cli" "Yellow" "💡"
        return
    }
    
    Write-ColorOutput "Iniciando processo de autenticação..." "Yellow" "🔑"
    Write-ColorOutput "Você será redirecionado para o browser para fazer login" "Cyan" "💡"
    Write-ColorOutput "Usando caminho: $global:GitHubCLIPath" "Gray" "🔍"
    
    try {
        & $global:GitHubCLIPath auth login --web
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "Autenticação realizada com sucesso!" "Green" "✅"
        } else {
            Write-ColorOutput "Falha na autenticação" "Red" "❌"
        }
    }
    catch {
        Write-ColorOutput "Erro ao executar GitHub CLI: $_" "Red" "❌"
        Write-ColorOutput "Caminho usado: $global:GitHubCLIPath" "Yellow" "💡"
    }
}

function Show-Documentation {
    Write-Title "DOCUMENTAÇÃO DISPONÍVEL"
    
    $docs = @(
        @{ File = "README.md"; Desc = "Visão geral do projeto" },
        @{ File = "CONQUISTE-TODAS-BADGES.md"; Desc = "Guia definitivo" },
        @{ File = "GUIA-EXECUCAO-DEFINITIVO.md"; Desc = "Instruções detalhadas" },
        @{ File = "docs/execution-guide.md"; Desc = "Guia passo a passo" }
    )
    
    Write-ColorOutput "Arquivos de documentação:" "Cyan" "📖"
    foreach ($doc in $docs) {
        if (Test-Path $doc.File) {
            Write-Host "  ✅ $($doc.File) - $($doc.Desc)"
        } else {
            Write-Host "  ❌ $($doc.File) - $($doc.Desc) (não encontrado)"
        }
    }
    
    Write-Host ""
    Write-ColorOutput "Links úteis:" "Cyan" "🔗"
    Write-Host "  - GitHub Profile: https://github.com/settings/profile"
    Write-Host "  - GitHub CLI Docs: https://cli.github.com/manual/"
    Write-Host "  - GitHub API: https://docs.github.com/en/rest"
    
    if (-not $NoInteraction) {
        Write-Host ""
        $view = Read-Host "Abrir guia definitivo? (S/N)"
        if ($view -eq "S" -or $view -eq "s" -or $view -eq "Y" -or $view -eq "y") {
            if (Test-Path "CONQUISTE-TODAS-BADGES.md") {
                if ($IsWindowsOS) {
                    Start-Process "CONQUISTE-TODAS-BADGES.md"
                } else {
                    Write-ColorOutput "Abra o arquivo: CONQUISTE-TODAS-BADGES.md" "Yellow" "💡"
                }
            }
        }
    }
}

# EXECUÇÃO PRINCIPAL
function Main {
    # Detectar SO
    $osName = if ($IsWindowsOS) { "Windows" } elseif ($IsLinuxOS) { "Linux" } elseif ($IsMacOSOS) { "macOS" } else { "Desconhecido" }
    
    Write-Title "GITHUB BADGES MASTERY - EXECUTOR UNIVERSAL"
    Write-ColorOutput "Sistema operacional: $osName" "Cyan" "💻"
    Write-ColorOutput "PowerShell: $($PSVersionTable.PSVersion)" "Cyan" "⚡"
    Write-Host ""
    
    # Modo rápido
    if ($QuickMode) {
        Write-ColorOutput "MODO RÁPIDO ATIVADO" "Yellow" "⚡"
        if (-not (Test-Prerequisites)) {
            if ($InstallPrereqs) {
                Install-Prerequisites
            } else {
                return
            }
        }
        Execute-CompleteAutomation
        return
    }
    
    # Instalar pré-requisitos se solicitado
    if ($InstallPrereqs) {
        Install-Prerequisites
        return
    }
    
    # Verificar pré-requisitos
    if (-not (Test-Prerequisites)) {
        Write-Host ""
        if (-not $NoInteraction) {
            $install = Read-Host "Deseja instalar os pré-requisitos automaticamente? (S/N)"
            if ($install -eq "S" -or $install -eq "s" -or $install -eq "Y" -or $install -eq "y") {
                Install-Prerequisites
                return
            }
        }
        Write-ColorOutput "Pré-requisitos não atendidos. Execute com -InstallPrereqs para instalar automaticamente." "Red" "❌"
        return
    }
    
    # Verificar autenticação
    if (-not (Test-GitHubAuth)) {
        Write-Host ""
        if (-not $NoInteraction) {
            $auth = Read-Host "Deseja configurar a autenticação GitHub agora? (S/N)"
            if ($auth -eq "S" -or $auth -eq "s" -or $auth -eq "Y" -or $auth -eq "y") {
                Setup-Authentication
            }
        }
    }
    
    # Menu interativo
    if (-not $NoInteraction) {
        do {
            Show-Menu
            $choice = Read-Host "Digite sua escolha (1-9)"
            
            switch ($choice) {
                "1" { Execute-CompleteAutomation }
                "2" { Show-Status }
                "3" { 
                    if (Test-Path "scripts/badge-monitor-advanced.js") {
                        node "scripts/badge-monitor-advanced.js" --suggest --automate
                    } else {
                        Show-Status
                    }
                }
                "4" { 
                    $script:DryRun = $true
                    Execute-CompleteAutomation 
                }
                "5" { Execute-QuickCommands }
                "6" { Install-Prerequisites }
                "7" { Setup-Authentication }
                "8" { Show-Documentation }
                "9" { 
                    Write-ColorOutput "Saindo..." "Yellow" "👋"
                    return 
                }
                default { 
                    Write-ColorOutput "Opção inválida!" "Red" "❌"
                }
            }
            
            if ($choice -ne "9") {
                Write-Host ""
                Read-Host "Pressione Enter para continuar"
            }
            
        } while ($choice -ne "9")
    } else {
        # Modo não interativo - execução automática
        Execute-CompleteAutomation
    }
    
    Write-Host ""
    Write-ColorOutput "OPERAÇÃO CONCLUÍDA!" "Green" "🎉"
    Write-ColorOutput "Verifique suas badges em: https://github.com/settings/profile" "Cyan" "🔗"
    Write-ColorOutput "Aguarde 2-4 horas para badges aparecerem no perfil" "Yellow" "⏰"
}

# Executar script principal
Main