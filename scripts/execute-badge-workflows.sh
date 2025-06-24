#!/bin/bash

# 🏆 GitHub Badges Mastery - Workflow Execution Script
# Script para executar workflows de badges do GitHub

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função para exibir banner
show_banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🏆 GITHUB BADGES MASTERY                  ║"
    echo "║                   Workflow Execution Script                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Função para exibir menu
show_menu() {
    echo -e "${YELLOW}📋 Workflows Disponíveis:${NC}"
    echo ""
    echo -e "${GREEN}1.${NC} 🧠 Galaxy Brain - Criar Discussões"
    echo -e "${GREEN}2.${NC} ❤️ Heart On Your Sleeve - Adicionar Reações"
    echo -e "${GREEN}3.${NC} 🎲 YOLO - Merge Direto"
    echo -e "${GREEN}4.${NC} 👥 Pair Programming - Co-autoria"
    echo -e "${GREEN}5.${NC} 🔄 Auto PR Creator - Criar PRs"
    echo -e "${GREEN}6.${NC} 📊 Badge Monitor - Verificar Progresso"
    echo -e "${GREEN}7.${NC} 🚀 Executar Todos os Workflows"
    echo -e "${GREEN}8.${NC} 📈 Status das Badges"
    echo -e "${GREEN}9.${NC} ❌ Sair"
    echo ""
}

# Função para verificar se gh CLI está instalado
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        echo -e "${RED}❌ GitHub CLI (gh) não está instalado!${NC}"
        echo -e "${YELLOW}📥 Instale em: https://cli.github.com/${NC}"
        exit 1
    fi
    
    if ! gh auth status &> /dev/null; then
        echo -e "${RED}❌ GitHub CLI não está autenticado!${NC}"
        echo -e "${YELLOW}🔐 Execute: gh auth login${NC}"
        exit 1
    fi
}

# Função para executar Galaxy Brain
execute_galaxy_brain() {
    echo -e "${PURPLE}🧠 Executando Galaxy Brain Workflow...${NC}"
    
    # Verificar se discussions estão habilitadas
    echo -e "${YELLOW}⚠️  IMPORTANTE: Certifique-se de que Discussions estão habilitadas no repositório!${NC}"
    echo -e "${YELLOW}   Vá em Settings > Features > Discussions ✅${NC}"
    echo ""
    
    read -p "Discussions estão habilitadas? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Habilitar discussions primeiro!${NC}"
        return 1
    fi
    
    # Executar workflow
    gh workflow run galaxy-brain-discussions.yml --field discussion_type=idea
    
    echo -e "${GREEN}✅ Galaxy Brain workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar Heart On Your Sleeve
execute_heart_on_sleeve() {
    echo -e "${PURPLE}❤️ Executando Heart On Your Sleeve Workflow...${NC}"
    
    echo -e "${YELLOW}Escolha o tipo de reação:${NC}"
    echo "1. ❤️ heart"
    echo "2. 🚀 rocket"
    echo "3. 👍 thumbsup"
    echo "4. 👀 eyes"
    echo "5. 🎉 tada"
    echo "6. 🎲 aleatório"
    
    read -p "Escolha (1-6): " reaction_choice
    
    case $reaction_choice in
        1) reaction="heart" ;;
        2) reaction="rocket" ;;
        3) reaction="thumbsup" ;;
        4) reaction="eyes" ;;
        5) reaction="tada" ;;
        6) reaction="" ;;
        *) reaction="heart" ;;
    esac
    
    echo -e "${YELLOW}Escolha o alvo:${NC}"
    echo "1. 📋 Apenas Issues"
    echo "2. 🔀 Apenas PRs"
    echo "3. 📋🔀 Ambos"
    
    read -p "Escolha (1-3): " target_choice
    
    case $target_choice in
        1) target="issues" ;;
        2) target="prs" ;;
        3) target="both" ;;
        *) target="both" ;;
    esac
    
    # Executar workflow
    if [ -n "$reaction" ]; then
        gh workflow run heart-on-sleeve-reactions.yml --field reaction_type="$reaction" --field target_type="$target"
    else
        gh workflow run heart-on-sleeve-reactions.yml --field target_type="$target"
    fi
    
    echo -e "${GREEN}✅ Heart On Your Sleeve workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar YOLO
execute_yolo() {
    echo -e "${PURPLE}🎲 Executando YOLO Workflow...${NC}"
    
    echo -e "${YELLOW}Escolha o tipo de conteúdo:${NC}"
    echo "1. 📝 Documentação"
    echo "2. 🔧 Correção Menor"
    echo "3. 📊 Atualização de Badge"
    echo "4. ⚙️ Automação"
    
    read -p "Escolha (1-4): " merge_choice
    
    case $merge_choice in
        1) merge_type="documentation" ;;
        2) merge_type="minor-fix" ;;
        3) merge_type="badge-update" ;;
        4) merge_type="automation" ;;
        *) merge_type="documentation" ;;
    esac
    
    echo -e "${YELLOW}Habilitar verificações de segurança? (y/n):${NC}"
    read -p "" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        safety_check="true"
    else
        safety_check="false"
    fi
    
    # Executar workflow
    gh workflow run yolo-direct-merge.yml --field merge_type="$merge_type" --field safety_check="$safety_check"
    
    echo -e "${GREEN}✅ YOLO workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar Pair Programming
execute_pair_programming() {
    echo -e "${PURPLE}👥 Executando Pair Programming Workflow...${NC}"
    
    read -p "Nome da feature (ou Enter para padrão): " feature_name
    feature_name=${feature_name:-"badge-enhancement"}
    
    # Executar workflow
    gh workflow run pair-programming.yml --field feature_name="$feature_name"
    
    echo -e "${GREEN}✅ Pair Programming workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar Auto PR Creator
execute_auto_pr_creator() {
    echo -e "${PURPLE}🔄 Executando Auto PR Creator Workflow...${NC}"
    
    echo -e "${YELLOW}Número de PRs a criar:${NC}"
    read -p "Quantidade (1-5): " pr_count
    pr_count=${pr_count:-1}
    
    echo -e "${YELLOW}Tipo de PR:${NC}"
    echo "1. 📚 Documentação"
    echo "2. 🚀 Feature"
    echo "3. 📚🚀 Misto"
    
    read -p "Escolha (1-3): " pr_type_choice
    
    case $pr_type_choice in
        1) pr_type="documentation" ;;
        2) pr_type="feature" ;;
        3) pr_type="mixed" ;;
        *) pr_type="documentation" ;;
    esac
    
    # Executar workflow
    gh workflow run auto-pr-creator.yml --field pr_count="$pr_count" --field pr_type="$pr_type"
    
    echo -e "${GREEN}✅ Auto PR Creator workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar Badge Monitor
execute_badge_monitor() {
    echo -e "${PURPLE}📊 Executando Badge Monitor Workflow...${NC}"
    
    # Executar workflow
    gh workflow run badge-monitor.yml
    
    echo -e "${GREEN}✅ Badge Monitor workflow iniciado!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para executar todos os workflows
execute_all_workflows() {
    echo -e "${PURPLE}🚀 Executando Todos os Workflows...${NC}"
    
    echo -e "${YELLOW}⚠️  Isso executará todos os workflows disponíveis!${NC}"
    read -p "Continuar? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Operação cancelada!${NC}"
        return 1
    fi
    
    # Executar workflows em sequência
    echo -e "${CYAN}1. Executando Galaxy Brain...${NC}"
    gh workflow run galaxy-brain-discussions.yml --field discussion_type=idea
    
    echo -e "${CYAN}2. Executando Heart On Your Sleeve...${NC}"
    gh workflow run heart-on-sleeve-reactions.yml --field reaction_type=heart --field target_type=both
    
    echo -e "${CYAN}3. Executando YOLO...${NC}"
    gh workflow run yolo-direct-merge.yml --field merge_type=documentation --field safety_check=true
    
    echo -e "${CYAN}4. Executando Pair Programming...${NC}"
    gh workflow run pair-programming.yml --field feature_name=comprehensive-badge-strategy
    
    echo -e "${CYAN}5. Executando Badge Monitor...${NC}"
    gh workflow run badge-monitor.yml
    
    echo -e "${GREEN}✅ Todos os workflows foram iniciados!${NC}"
    echo -e "${BLUE}🔗 Monitore em: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/actions${NC}"
}

# Função para mostrar status das badges
show_badge_status() {
    echo -e "${PURPLE}📈 Status das Badges:${NC}"
    echo ""
    
    # Verificar PRs merged
    pr_count=$(gh pr list --state merged --json number | jq length 2>/dev/null || echo "0")
    echo -e "${GREEN}🦈 Pull Shark:${NC} $pr_count/2 PRs merged"
    
    # Verificar commits com co-autoria
    coauthor_count=$(git log --grep="Co-authored-by" --oneline | wc -l 2>/dev/null || echo "0")
    echo -e "${GREEN}👥 Pair Extraordinaire:${NC} $coauthor_count co-authored commits"
    
    # Verificar workflows
    workflow_count=$(find .github/workflows -name "*.yml" 2>/dev/null | wc -l || echo "0")
    echo -e "${GREEN}⚙️ DevOps Guru:${NC} $workflow_count workflows"
    
    # Verificar issues com reações
    issues_with_reactions=$(gh issue list --json number,reactions 2>/dev/null | jq '[.[] | select(.reactions | length > 0)] | length' || echo "0")
    echo -e "${GREEN}❤️ Heart On Your Sleeve:${NC} $issues_with_reactions issues with reactions"
    
    # Verificar discussões
    discussion_count=$(gh api graphql -f query='query($owner: String!, $repo: String!) { repository(owner: $owner, name: $repo) { discussions(first: 100) { totalCount } } }' -f owner="$(gh repo view --json owner -q .owner.login)" -f repo="$(gh repo view --json name -q .name)" --jq '.data.repository.discussions.totalCount' 2>/dev/null || echo "0")
    echo -e "${GREEN}🧠 Galaxy Brain:${NC} $discussion_count discussions"
    
    echo ""
    echo -e "${YELLOW}📊 Progresso Geral:${NC}"
    achieved=0
    [ "$pr_count" -ge 2 ] && achieved=$((achieved + 1))
    [ "$coauthor_count" -ge 1 ] && achieved=$((achieved + 1))
    [ "$workflow_count" -ge 1 ] && achieved=$((achieved + 1))
    [ "$issues_with_reactions" -ge 1 ] && achieved=$((achieved + 1))
    [ "$discussion_count" -ge 1 ] && achieved=$((achieved + 1))
    
    echo -e "${GREEN}🏆 Badges Conquistadas: $achieved/7${NC}"
    echo -e "${BLUE}📈 Percentual: $((achieved * 100 / 7))%${NC}"
}

# Função principal
main() {
    show_banner
    check_gh_cli
    
    while true; do
        show_menu
        read -p "Escolha uma opção (1-9): " choice
        
        case $choice in
            1) execute_galaxy_brain ;;
            2) execute_heart_on_sleeve ;;
            3) execute_yolo ;;
            4) execute_pair_programming ;;
            5) execute_auto_pr_creator ;;
            6) execute_badge_monitor ;;
            7) execute_all_workflows ;;
            8) show_badge_status ;;
            9) 
                echo -e "${GREEN}👋 Até logo!${NC}"
                exit 0
                ;;
            *) 
                echo -e "${RED}❌ Opção inválida!${NC}"
                ;;
        esac
        
        echo ""
        read -p "Pressione Enter para continuar..."
        clear
    done
}

# Executar função principal
main "$@" 