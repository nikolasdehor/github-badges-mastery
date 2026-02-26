#!/bin/bash
# 🏆 GitHub Badges Mastery - Auto Launcher
# Detecta o SO e executa a versão apropriada

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função para output colorido
color_echo() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Detectar SO
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Verificar se PowerShell está disponível
check_powershell() {
    if command -v pwsh &> /dev/null; then
        echo "pwsh"
    elif command -v powershell &> /dev/null; then
        echo "powershell"
    else
        echo "none"
    fi
}

# Instalar PowerShell se necessário
install_powershell() {
    local os=$1
    
    color_echo $YELLOW "📦 PowerShell não encontrado. Instalando..."
    
    case $os in
        "linux")
            # Detectar distribuição Linux
            if command -v apt &> /dev/null; then
                # Ubuntu/Debian
                color_echo $CYAN "🐧 Detectado Ubuntu/Debian"
                sudo apt update
                sudo apt install -y wget apt-transport-https software-properties-common
                wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                sudo apt update
                sudo apt install -y powershell
            elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
                # RHEL/CentOS/Fedora
                color_echo $CYAN "🐧 Detectado RHEL/CentOS/Fedora"
                curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo rpm --import -
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
                    sudo dnf install -y powershell
                else
                    sudo yum install -y https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
                    sudo yum install -y powershell
                fi
            elif command -v pacman &> /dev/null; then
                # Arch Linux
                color_echo $CYAN "🐧 Detectado Arch Linux"
                sudo pacman -S --noconfirm powershell-bin
            else
                color_echo $RED "❌ Distribuição Linux não suportada para instalação automática"
                color_echo $YELLOW "💡 Visite: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux"
                return 1
            fi
            ;;
        "macos")
            color_echo $CYAN "🍎 Detectado macOS"
            if command -v brew &> /dev/null; then
                brew install powershell
            else
                color_echo $YELLOW "📦 Homebrew não encontrado. Instalando..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                brew install powershell
            fi
            ;;
        *)
            color_echo $RED "❌ SO não suportado para instalação automática do PowerShell"
            return 1
            ;;
    esac
    
    color_echo $GREEN "✅ PowerShell instalado!"
}

# Função principal
main() {
    color_echo $MAGENTA ""
    color_echo $MAGENTA "🏆 GITHUB BADGES MASTERY - AUTO LAUNCHER"
    color_echo $MAGENTA "========================================="
    color_echo $MAGENTA ""
    
    # Detectar SO
    local os=$(detect_os)
    color_echo $CYAN "💻 Sistema operacional detectado: $os"
    
    # Verificar PowerShell
    local ps_cmd=$(check_powershell)
    
    if [[ $ps_cmd == "none" ]]; then
        color_echo $YELLOW "⚠️ PowerShell não encontrado"
        
        if [[ $os == "windows" ]]; then
            color_echo $RED "❌ PowerShell deveria estar disponível no Windows"
            color_echo $YELLOW "💡 Execute este script no PowerShell ou instale PowerShell 7"
            return 1
        fi
        
        read -p "Deseja instalar PowerShell automaticamente? (S/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[SsYy]$ ]]; then
            install_powershell $os
            ps_cmd=$(check_powershell)
            if [[ $ps_cmd == "none" ]]; then
                color_echo $RED "❌ Falha na instalação do PowerShell"
                return 1
            fi
        else
            color_echo $YELLOW "💡 Instale PowerShell manualmente: https://github.com/PowerShell/PowerShell"
            return 1
        fi
    fi
    
    color_echo $GREEN "✅ PowerShell encontrado: $ps_cmd"
    
    # Verificar se o executor universal existe
    if [[ ! -f "EXECUTE-BADGES-UNIVERSAL.ps1" ]]; then
        color_echo $RED "❌ EXECUTE-BADGES-UNIVERSAL.ps1 não encontrado"
        color_echo $YELLOW "💡 Certifique-se de estar no diretório correto do projeto"
        return 1
    fi
    
    # Executar o script universal
    color_echo $CYAN "🚀 Executando GitHub Badges Mastery..."
    color_echo $CYAN ""
    
    # Passar argumentos para o script PowerShell
    local args=""
    for arg in "$@"; do
        case $arg in
            --dry-run|-d)
                args="$args -DryRun"
                ;;
            --quick|-q)
                args="$args -QuickMode"
                ;;
            --install|-i)
                args="$args -InstallPrereqs"
                ;;
            --no-interaction|-n)
                args="$args -NoInteraction"
                ;;
        esac
    done
    
    # Executar com PowerShell
    $ps_cmd -File "EXECUTE-BADGES-UNIVERSAL.ps1" $args
    
    local exit_code=$?
    
    if [[ $exit_code -eq 0 ]]; then
        color_echo $GREEN ""
        color_echo $GREEN "🎉 Execução concluída com sucesso!"
    else
        color_echo $RED ""
        color_echo $RED "❌ Execução falhou com código: $exit_code"
    fi
    
    return $exit_code
}

# Verificar se está sendo executado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi