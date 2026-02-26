@echo off
REM 🏆 GitHub Badges Master - Execução Automática Total
REM Script em lote para conquistar todas as badges do GitHub

echo.
echo 🏆 GITHUB BADGES MASTER - AUTOMACAO TOTAL
echo ==========================================
echo.

REM Verificar se está no diretório correto
if not exist "MASTER-BADGE-AUTOMATION.ps1" (
    echo ❌ Erro: Execute este script no diretorio do projeto github-badges-mastery
    echo 📁 Navegue para: C:\Users\Nikolas_Vale\Documents\github-badges-mastery
    pause
    exit /b 1
)

echo 🔍 Verificando pré-requisitos...

REM Verificar GitHub CLI
gh --version >nul 2>&1
if errorlevel 1 (
    echo ❌ GitHub CLI não encontrado!
    echo 💡 Instale com: winget install GitHub.cli
    pause
    exit /b 1
)

REM Verificar autenticação
gh auth status >nul 2>&1
if errorlevel 1 (
    echo ❌ GitHub CLI não está autenticado!
    echo 💡 Execute: gh auth login
    pause
    exit /b 1
)

REM Verificar Git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git não encontrado!
    echo 💡 Instale com: winget install Git.Git
    pause
    exit /b 1
)

echo ✅ Todos os pré-requisitos atendidos!
echo.

REM Menu de opções
echo 🎯 ESCOLHA UMA OPCAO:
echo.
echo 1. 🚀 EXECUCAO COMPLETA (Conquista todas as badges automaticamente)
echo 2. 🔍 VERIFICAR STATUS (Apenas mostra o progresso atual)
echo 3. 📊 EXECUTAR MONITOR AVANCADO (Monitoramento detalhado)
echo 4. 🧪 MODO TESTE (Dry run - não executa ações)
echo 5. ⚡ COMANDOS RAPIDOS MANUAIS
echo 6. 📚 MOSTRAR DOCUMENTACAO
echo.
set /p choice="Digite sua escolha (1-6): "

if "%choice%"=="1" goto execucao_completa
if "%choice%"=="2" goto verificar_status
if "%choice%"=="3" goto monitor_avancado
if "%choice%"=="4" goto modo_teste
if "%choice%"=="5" goto comandos_rapidos
if "%choice%"=="6" goto documentacao

echo ❌ Opção inválida!
pause
exit /b 1

:execucao_completa
echo.
echo 🚀 EXECUTANDO AUTOMACAO COMPLETA...
echo ====================================
echo.
echo ⚠️ Este processo irá:
echo   - Criar commits com co-autoria
echo   - Executar workflows do GitHub Actions
echo   - Criar e mergear pull requests
echo   - Criar issues e adicionar reações
echo.
set /p confirm="Confirma a execução? (S/N): "
if /i not "%confirm%"=="S" goto menu

echo.
echo 🎯 Executando MASTER-BADGE-AUTOMATION.ps1...
powershell -ExecutionPolicy Bypass -File "MASTER-BADGE-AUTOMATION.ps1"

echo.
echo ✅ Automação completa executada!
echo 📝 Próximos passos:
echo   1. Habilite Discussions em: Settings → Features → Discussions
echo   2. Crie discussões usando templates em .github/DISCUSSION_TEMPLATE/
echo   3. Aguarde 2-4 horas para badges aparecerem no perfil
echo   4. Verifique em: https://github.com/settings/profile
goto fim

:verificar_status
echo.
echo 📊 VERIFICANDO STATUS ATUAL...
echo ==============================
echo.
powershell -ExecutionPolicy Bypass -File "scripts\badge-monitor-complete.ps1" -ShowQuickCommands
echo.
echo 📋 Para execução avançada:
echo   node scripts\badge-monitor-advanced.js
goto fim

:monitor_avancado
echo.
echo 📊 EXECUTANDO MONITOR AVANCADO...
echo =================================
echo.
REM Verificar se Node.js está disponível
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js não encontrado!
    echo 💡 Instale com: winget install OpenJS.NodeJS
    echo.
    echo Executando monitor PowerShell alternativo...
    powershell -ExecutionPolicy Bypass -File "scripts\badge-monitor-complete.ps1" -GenerateReport
) else (
    node scripts\badge-monitor-advanced.js --suggest --automate
)
goto fim

:modo_teste
echo.
echo 🧪 MODO TESTE (DRY RUN)...
echo =========================
echo.
echo 🔍 Executando em modo teste - nenhuma ação será realizada
powershell -ExecutionPolicy Bypass -File "MASTER-BADGE-AUTOMATION.ps1" -DryRun
goto fim

:comandos_rapidos
echo.
echo ⚡ COMANDOS RAPIDOS MANUAIS
echo ==========================
echo.
echo 📋 Execute os comandos abaixo em sequência:
echo.
echo 1. PAIR EXTRAORDINAIRE:
echo    git add . ^&^& git commit -m "🏆 badge automation^n^nCo-authored-by: GitHub Copilot ^<copilot@github.com^>" ^&^& git push
echo.
echo 2. DEVOPS GURU:
echo    gh workflow run ci.yml
echo.
echo 3. QUICKDRAW + HEART:
echo    gh workflow run quickdraw-issues.yml
echo.
echo 4. YOLO:
echo    gh workflow run yolo-merge.yml
echo.
echo 5. PULL SHARK:
echo    gh workflow run pull-shark-automated.yml
echo.
echo 6. GALAXY BRAIN (MANUAL):
echo    - Vá para Settings → Features → Discussions ✅
echo    - Crie discussões usando templates em .github/DISCUSSION_TEMPLATE/
echo.
set /p execute_manual="Executar comandos automaticamente? (S/N): "
if /i "%execute_manual%"=="S" (
    echo.
    echo 🚀 Executando comandos...
    
    echo 👥 Executando Pair Extraordinaire...
    git add .
    git commit -m "🏆 badge automation system complete^n^nCo-authored-by: GitHub Copilot <copilot@github.com>^nCo-authored-by: Badge System <automation@badges.dev>"
    git push
    
    echo ⚙️ Executando DevOps Guru...
    gh workflow run ci.yml
    
    echo ⚡ Executando Quickdraw + Heart...
    gh workflow run quickdraw-issues.yml
    
    echo 🎲 Executando YOLO...
    gh workflow run yolo-merge.yml
    
    echo 🦈 Executando Pull Shark...
    gh workflow run pull-shark-automated.yml
    
    echo.
    echo ✅ Comandos executados! Aguarde alguns minutos e verifique o progresso.
)
goto fim

:documentacao
echo.
echo 📚 DOCUMENTACAO DISPONIVEL
echo ==========================
echo.
echo 📖 Arquivos de documentação:
echo   - README.md (Visão geral)
echo   - CONQUISTE-TODAS-BADGES.md (Guia definitivo)
echo   - GUIA-EXECUCAO-DEFINITIVO.md (Instruções detalhadas)
echo   - docs\execution-guide.md (Guia passo a passo)
echo.
echo 🔗 Links úteis:
echo   - GitHub Profile: https://github.com/settings/profile
echo   - GitHub CLI Docs: https://cli.github.com/manual/
echo   - GitHub API: https://docs.github.com/en/rest
echo.
echo 📋 Scripts disponíveis:
echo   - MASTER-BADGE-AUTOMATION.ps1 (Script principal)
echo   - scripts\badge-monitor-complete.ps1 (Monitor PowerShell)
echo   - scripts\badge-monitor-advanced.js (Monitor Node.js)
echo.
set /p view_doc="Abrir guia definitivo? (S/N): "
if /i "%view_doc%"=="S" (
    start CONQUISTE-TODAS-BADGES.md
)
goto fim

:fim
echo.
echo 🎉 OPERACAO CONCLUIDA!
echo ======================
echo.
echo 🔗 Verifique suas badges em: https://github.com/settings/profile
echo 📊 Execute novamente para verificar progresso
echo 💡 Aguarde 2-4 horas para badges aparecerem no perfil
echo.
pause