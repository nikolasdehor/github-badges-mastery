@echo off
REM 🏆 GitHub Badges Master - Versão Manual (Sem GitHub CLI)
REM Script para quando GitHub CLI não está disponível

echo.
echo 🏆 GITHUB BADGES MASTER - VERSAO MANUAL
echo =======================================
echo ⚠️ Esta versão não requer GitHub CLI
echo.

REM Verificar se está no diretório correto
if not exist "README.md" (
    echo ❌ Erro: Execute este script no diretorio do projeto
    echo 📁 Navegue para: C:\Users\Nikolas_Vale\Documents\github-badges-mastery
    pause
    exit /b 1
)

echo 🎯 ESCOLHA UMA OPCAO:
echo.
echo 1. 📋 MOSTRAR COMANDOS MANUAIS (Git + Web)
echo 2. 👥 EXECUTAR PAIR EXTRAORDINAIRE (Apenas Git)
echo 3. 📚 MOSTRAR GUIA COMPLETO
echo 4. 🔧 INSTALAR GITHUB CLI
echo 5. 🌐 ABRIR LINKS ÚTEIS
echo.
set /p choice="Digite sua escolha (1-5): "

if "%choice%"=="1" goto comandos_manuais
if "%choice%"=="2" goto pair_extraordinaire
if "%choice%"=="3" goto guia_completo
if "%choice%"=="4" goto instalar_cli
if "%choice%"=="5" goto links_uteis

echo ❌ Opção inválida!
pause
exit /b 1

:comandos_manuais
echo.
echo 📋 COMANDOS MANUAIS PARA CONQUISTAR BADGES
echo ==========================================
echo.
echo 🥇 ETAPA 1: PAIR EXTRAORDINAIRE (Git apenas)
echo.
echo git add .
echo git commit -m "🏆 GitHub badges automation system
echo.
echo Complete badge automation system for GitHub achievements.
echo Includes workflows, scripts, and comprehensive documentation.
echo.
echo Co-authored-by: GitHub Copilot ^<copilot@github.com^>
echo Co-authored-by: Badge System ^<automation@badges.dev^>"
echo git push origin main
echo.
echo 🥈 ETAPA 2: BADGES VIA GITHUB WEB (Manual)
echo.
echo 1. 🌐 Vá para: https://github.com/%USERNAME%/github-badges-mastery
echo 2. ⚙️ DEVOPS GURU: Actions → ci.yml → Run workflow
echo 3. ⚡ QUICKDRAW: Actions → quickdraw-issues.yml → Run workflow
echo 4. 🎲 YOLO: Actions → yolo-merge.yml → Run workflow  
echo 5. 🦈 PULL SHARK: Actions → auto-pr-creator.yml → Run workflow
echo 6. 🧠 GALAXY BRAIN: Settings → Features → Discussions ✅
echo.
echo 🥉 ETAPA 3: VERIFICAR PROGRESSO
echo.
echo 1. 🏆 Perfil: https://github.com/settings/profile
echo 2. 📊 Atividade: https://github.com/%USERNAME%
echo 3. ⏰ Aguarde 2-4 horas para badges aparecerem
echo.
set /p execute="Executar Pair Extraordinaire agora? (S/N): "
if /i "%execute%"=="S" goto pair_extraordinaire
goto fim

:pair_extraordinaire
echo.
echo 👥 EXECUTANDO PAIR EXTRAORDINAIRE...
echo ===================================
echo.
echo 📝 Criando commit com co-autoria...

git add .
if errorlevel 1 (
    echo ❌ Erro: Verifique se está em um repositório Git
    goto fim
)

git commit -m "🏆 GitHub badges automation system

Complete badge automation system for GitHub achievements.
Includes workflows, scripts, and comprehensive documentation
for systematically acquiring all GitHub profile badges.

Features:
- Automated workflow execution
- Cross-platform compatibility  
- Real-time progress monitoring
- Comprehensive error handling

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Badge System <automation@badges.dev>"

if errorlevel 1 (
    echo ⚠️ Commit pode ter falhado (talvez não há mudanças)
    echo 💡 Tente fazer uma pequena mudança em um arquivo primeiro
) else (
    echo ✅ Commit criado com sucesso!
)

echo.
echo 📤 Fazendo push...
git push origin main

if errorlevel 1 (
    echo ❌ Push falhou. Verifique:
    echo    1. Se você tem permissões no repositório
    echo    2. Se está autenticado no Git
    echo    3. Se o remote está configurado
    echo.
    echo 🔧 Para configurar Git:
    echo git config --global user.name "Seu Nome"
    echo git config --global user.email "seuemail@email.com"
) else (
    echo ✅ Push realizado com sucesso!
    echo.
    echo 🎉 PAIR EXTRAORDINAIRE CONQUISTADO!
    echo.
    echo 📋 Próximos passos:
    echo 1. Vá para https://github.com/%USERNAME%/github-badges-mastery/actions
    echo 2. Execute os workflows manualmente
    echo 3. Aguarde 2-4 horas para badge aparecer
)
goto fim

:guia_completo
echo.
echo 📚 GUIA COMPLETO DE BADGES
echo =========================
echo.
echo 📖 Documentação disponível:
echo    - README.md
echo    - CONQUISTE-TODAS-BADGES.md  
echo    - GUIA-EXECUCAO-DEFINITIVO.md
echo.
echo 🔗 Links importantes:
echo    - Seu repositório: https://github.com/%USERNAME%/github-badges-mastery
echo    - GitHub Actions: https://github.com/%USERNAME%/github-badges-mastery/actions
echo    - Perfil badges: https://github.com/settings/profile
echo    - Discussions: https://github.com/%USERNAME%/github-badges-mastery/discussions
echo.
echo 📊 Estratégias por badge:
echo.
echo 👥 PAIR EXTRAORDINAIRE:
echo    - Commit com Co-authored-by
echo    - Execute: Opção 2 deste menu
echo.
echo ⚙️ DEVOPS GURU:
echo    - Execute workflows no GitHub Actions
echo    - Múltiplos workflows = maior chance
echo.
echo ⚡ QUICKDRAW:
echo    - Crie issues rapidamente (^<5min)
echo    - Use workflow quickdraw-issues.yml
echo.
echo ❤️ HEART ON YOUR SLEEVE:
echo    - Adicione reações em issues
echo    - Automaticamente incluído no quickdraw
echo.
echo 🎲 YOLO:
echo    - Merge PR sem review
echo    - Use workflow yolo-merge.yml
echo.
echo 🦈 PULL SHARK:
echo    - 2+ PRs merged
echo    - Use workflow auto-pr-creator.yml
echo.
echo 🧠 GALAXY BRAIN:
echo    - Discussões aceitas
echo    - Manual: Settings → Discussions
echo.
set /p open_guide="Abrir guia definitivo? (S/N): "
if /i "%open_guide%"=="S" (
    start CONQUISTE-TODAS-BADGES.md
)
goto fim

:instalar_cli
echo.
echo 🔧 INSTALAÇÃO DO GITHUB CLI
echo ===========================
echo.
echo 💡 OPÇÕES DE INSTALAÇÃO:
echo.
echo 1️⃣ WINGET (Recomendado):
echo    winget install GitHub.cli
echo.
echo 2️⃣ CHOCOLATEY:
echo    choco install gh
echo.
echo 3️⃣ DOWNLOAD MANUAL:
echo    https://cli.github.com/
echo.
echo 4️⃣ SCRIPT AUTOMÁTICO:
echo    Execute: .\INSTALL-PREREQUISITES.ps1
echo.
set /p install_method="Escolha o método (1-4): "

if "%install_method%"=="1" (
    echo.
    echo 📦 Executando winget install GitHub.cli...
    winget install GitHub.cli
    if errorlevel 1 (
        echo ❌ Falha no winget. Tente outro método.
    ) else (
        echo ✅ GitHub CLI instalado! Feche e reabra o terminal.
    )
)

if "%install_method%"=="4" (
    echo.
    echo 🚀 Executando script de instalação automática...
    powershell -ExecutionPolicy Bypass -File "INSTALL-PREREQUISITES.ps1"
)

if "%install_method%"=="3" (
    start https://cli.github.com/
)

echo.
echo 📋 APÓS A INSTALAÇÃO:
echo 1. Feche e reabra o terminal
echo 2. Execute: gh auth login
echo 3. Execute: .\EXECUTE-BADGES-MASTER.bat
goto fim

:links_uteis
echo.
echo 🌐 LINKS ÚTEIS
echo ==============
echo.
echo 🏆 GITHUB PROFILE:
echo    https://github.com/settings/profile
echo.
echo 📊 SEU REPOSITÓRIO:
echo    https://github.com/%USERNAME%/github-badges-mastery
echo.
echo ⚙️ GITHUB ACTIONS:
echo    https://github.com/%USERNAME%/github-badges-mastery/actions
echo.
echo 💬 DISCUSSIONS:
echo    https://github.com/%USERNAME%/github-badges-mastery/discussions
echo.
echo 📚 DOCUMENTAÇÃO:
echo    https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile/customizing-your-profile/personalizing-your-profile#displaying-badges-on-your-profile
echo.
echo 🔧 GITHUB CLI:
echo    https://cli.github.com/
echo.
set /p open_profile="Abrir seu perfil GitHub? (S/N): "
if /i "%open_profile%"=="S" (
    start https://github.com/settings/profile
)
goto fim

:fim
echo.
echo 🎉 OPERACAO CONCLUIDA!
echo ======================
echo.
echo 💡 LEMBRETES IMPORTANTES:
echo.
echo 1. 🔧 Para automação completa, instale GitHub CLI
echo 2. 🌐 Execute workflows manualmente via web se necessário
echo 3. ⏰ Badges aparecem em 2-4 horas após ações
echo 4. 🏆 Verifique progresso em: github.com/settings/profile
echo.
echo 📋 STATUS ATUAL:
if exist ".git" (
    echo ✅ Repositório Git detectado
) else (
    echo ❌ Não é um repositório Git
)

where git >nul 2>&1
if errorlevel 1 (
    echo ❌ Git não encontrado
) else (
    echo ✅ Git disponível
)

where gh >nul 2>&1
if errorlevel 1 (
    echo ❌ GitHub CLI não encontrado
) else (
    echo ✅ GitHub CLI disponível
)

echo.
pause