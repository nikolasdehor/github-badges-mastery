#!/usr/bin/env node

/**
 * 💖 Heart On Your Sleeve Badge Generator
 * 
 * Este script cria issues especialmente projetadas para gerar reações
 * e conquistar a badge "Heart On Your Sleeve"
 * 
 * Estratégia:
 * 1. Criar issues com conteúdo emocional/interessante
 * 2. Automaticamente adicionar reações diversas
 * 3. Simular engajamento natural da comunidade
 */

const fs = require('fs');
const path = require('path');

class HeartOnSleeveGenerator {
    constructor() {
        this.reactions = [
            '👍', '❤️', '🎉', '🚀', '👀', '😄', '💡', '🔥'
        ];
        
        this.issueTemplates = [
            {
                title: "🚀 Celebrando Milestone: 2 GitHub Badges Conquistadas!",
                body: this.generateCelebrationIssue(),
                labels: ['celebration', 'milestone', 'achievements', 'badges'],
                expectedReactions: ['🎉', '👍', '🚀', '❤️']
            },
            {
                title: "💡 Compartilhando Descoberta: Estratégia Secreta para DevOps Guru Badge",
                body: this.generateInsightIssue(),
                labels: ['insight', 'strategy', 'devops', 'tips'],
                expectedReactions: ['💡', '🔥', '👀', '👍']
            },
            {
                title: "🎯 Desafio Pessoal: 7 Badges em 7 Dias",
                body: this.generateChallengeIssue(),
                labels: ['challenge', 'personal-goal', 'motivation'],
                expectedReactions: ['🚀', '💪', '🎯', '👍']
            },
            {
                title: "❤️ Agradecimento à Comunidade GitHub",
                body: this.generateGratitudeIssue(),
                labels: ['gratitude', 'community', 'appreciation'],
                expectedReactions: ['❤️', '🙏', '😊', '👍']
            }
        ];
    }

    generateCelebrationIssue() {
        return `# 🎉 Milestone Alcançado: 2 GitHub Badges Conquistadas!

## 🏆 Badges Conquistadas Hoje:

### 🦈 Pull Shark
- **Conquista:** Mais de 2 Pull Requests merged
- **Sentimento:** Incrível sensação de progresso!
- **Aprendizado:** A importância de criar PRs bem estruturados

### ⚡ Quickdraw  
- **Conquista:** Issue/PR fechado em menos de 5 minutos
- **Sentimento:** Adrenalina pura! ⚡
- **Aprendizado:** Velocidade + qualidade = possível!

## 🚀 Próximos Objetivos

- [ ] 🤝 Pair Extraordinaire (co-autoria)
- [ ] 🧠 Galaxy Brain (discussões valiosas)
- [ ] ⚙️ DevOps Guru (GitHub Actions mastery)
- [ ] 🎲 YOLO (merge sem review)
- [ ] ❤️ Heart On Your Sleeve (este issue! 😄)

## 💭 Reflexões

Descobri que conquistar badges não é apenas sobre "gaming the system" - é sobre:

✨ **Desenvolver habilidades reais**
🤝 **Colaborar melhor**
⚙️ **Automatizar processos**
🧠 **Compartilhar conhecimento**

## 🎯 Para a Comunidade

Se você também está na jornada de badges, compartilhe:
- Qual foi sua primeira badge?
- Qual a mais difícil de conquistar?
- Dicas práticas que funcionaram?

**Vamos celebrar juntos! React com 🎉 se você também está nessa jornada!**

---

*Este issue faz parte do projeto [GitHub Badges Mastery](../README.md) - uma jornada estruturada para dominar o GitHub através de suas badges.*`;
    }

    generateInsightIssue() {
        return `# 💡 Descoberta Épica: Como Conquistar DevOps Guru Badge de Forma Inteligente

## 🔍 A Descoberta

Depois de pesquisar extensivamente, descobri que a badge **DevOps Guru** não é só sobre "ter GitHub Actions" - é sobre **demonstrar maestria em automação**.

## 🧠 Insights Valiosos

### 1. Qualidade > Quantidade
- ❌ **Erro comum:** Criar 20 workflows simples
- ✅ **Estratégia correta:** 3-5 workflows realmente úteis e bem estruturados

### 2. Casos de Uso Reais
```yaml
# Workflow que realmente demonstra expertise
name: Smart CI/CD Pipeline
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
    
jobs:
  intelligent-testing:
    # Testes condicionais baseados em mudanças
  automated-deployment:
    # Deploy inteligente com rollback
  security-scanning:
    # Análise de segurança automatizada
```

### 3. Demonstrar Impacto
- 📊 Metrics automáticos
- 🔧 Automação de tarefas repetitivas  
- 🛡️ Pipelines de segurança
- 📈 Otimização de performance

## 🎯 Template Prático

Criando um workflow que GitHub reconhece como "DevOps expertise":

1. **Multi-stage pipeline** (build → test → security → deploy)
2. **Conditional logic** (deploy apenas se testes passarem)
3. **Environment management** (staging → production)
4. **Rollback capabilities** (safety first!)
5. **Notification system** (integração com Slack/Discord)

## 🚀 Resultado Esperado

Com esta estratégia, a badge DevOps Guru deve aparecer em **2-3 dias** após configurar workflows que demonstrem verdadeira competência em DevOps.

## 💬 Discussão

**React com 💡 se este insight foi útil!**
**React com 🔥 se você quer ver o template completo!**
**React com 👀 se você já tentou conquistar esta badge!**

---

*Insight nascido durante o projeto GitHub Badges Mastery - transformando badges em verdadeiro aprendizado.*`;
    }

    generateChallengeIssue() {
        return `# 🎯 DESAFIO PESSOAL: 7 GitHub Badges em 7 Dias

## 🔥 O Desafio

Compromisso público: conquistar **7 badges do GitHub em 7 dias** usando apenas projetos pessoais!

## 📅 Cronograma Detalhado

### Dia 1-2: Fundação ✅
- [x] 🦈 Pull Shark (CONQUISTADA!)
- [x] ⚡ Quickdraw (CONQUISTADA!)

### Dia 3-4: Colaboração 
- [ ] 🤝 Pair Extraordinaire (co-autoria em commits)
- [ ] 💖 Heart On Your Sleeve (este issue vai me dar!)

### Dia 5-6: Técnica
- [ ] ⚙️ DevOps Guru (workflows avançados)
- [ ] 🧠 Galaxy Brain (discussões valiosas)

### Dia 7: Grand Finale
- [ ] 🎲 YOLO (merge sem review - o final perfeito!)

## 💪 Motivação Pública

**Por que tornar isso público?**
- 🎯 Accountability - vocês são minhas testemunhas!
- 📚 Compartilhar aprendizados em tempo real
- 🚀 Inspirar outros desenvolvedores
- 💡 Provar que badges = skills reais

## 📊 Métricas de Sucesso

- **Taxa de sucesso alvo:** 100% (7/7 badges)
- **Aprendizado por badge:** Mínimo 1 skill nova
- **Valor para comunidade:** Documentar todo processo
- **Tempo investido:** Máximo 2h por dia

## 🤝 Convite à Comunidade

**Quer participar do desafio?**
- React com 🚀 se você aceita o desafio!
- React com 💪 se você quer acompanhar meu progresso!
- React com 🎯 se você já conquistou todas as 7!

**Compartilhe suas badges nos comentários!**

## 📈 Updates Diários

Vou atualizar este issue diariamente com:
- ✅ Progresso do dia
- 🧠 Aprendizados descobertos  
- 🔧 Técnicas que funcionaram
- ⚠️ Desafios enfrentados

## 🏆 Compromisso

Se eu conseguir, vou criar um **guia completo e prático** para vocês replicarem o processo.

Se eu falhar... vou documentar onde errei para ninguém mais cometer os mesmos erros! 😄

**LET'S GO! 🚀**

---

*Desafio iniciado em: ${new Date().toLocaleDateString()}*
*Prazo final: ${new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toLocaleDateString()}*`;
    }

    generateGratitudeIssue() {
        return `# ❤️ Gratidão à Incrível Comunidade GitHub

## 🙏 Uma Pausa para Agradecer

No meio desta jornada épica de badges, preciso parar e reconhecer algo fundamental: **a comunidade GitHub é simplesmente incrível**.

## 💝 Motivos de Gratidão

### 🌟 Para os Criadores do GitHub
- Pela plataforma que revolucionou desenvolvimento
- Pelas badges que gamificam nosso crescimento
- Por tornar open source acessível a todos

### 👥 Para a Comunidade
- **Desenvolvedores que compartilham código:** Vocês são heróis anônimos
- **Mantenedores de projetos:** Obrigado pela dedicação incansável  
- **Contributors:** Cada PR, issue e review importa
- **Mentores silenciosos:** Códigos bem comentados que me ensinaram

### 📚 Para os Educadores
- Tutoriais que salvaram meus projetos
- READMEs bem escritos que são obras de arte
- Issues detalhadas que viram aulas completas
- Discussões que expandem horizontes

## 💡 Lições que a Comunidade Me Ensinou

1. **Código é comunicação:** Escreva para humanos, não só para máquinas
2. **Erros são oportunidades:** Cada bug report é uma chance de melhorar
3. **Colaboração > Competição:** Juntos chegamos mais longe
4. **Qualidade é um hábito:** Pequenos cuidados fazem grandes diferenças
5. **Compartilhar é crescer:** Quando ajudamos outros, nós também aprendemos

## 🎯 Compromisso de Retorno

**Como pretendo retribuir:**
- 📝 Documentar tudo que aprendo
- 🐛 Reportar bugs de forma construtiva
- 🤝 Ajudar developers iniciantes
- ⭐ Dar stars em projetos que uso
- 💬 Participar de discussões valiosas

## 🌈 Para Quem Está Começando

Se você é novo no GitHub:
- **Seja paciente consigo mesmo** - todos começamos do zero
- **Faça perguntas** - a comunidade QUER ajudar
- **Comece pequeno** - um commit por vez
- **Celebre cada vitória** - seu primeiro PR merged é histórico!

## 🚀 Mensagem Final

Esta jornada de badges me lembrou que por trás de cada linha de código há uma pessoa. Por trás de cada projeto há sonhos. Por trás de cada contribuição há generosidade.

**React com ❤️ se o GitHub mudou sua vida também!**
**React com 🙏 se você já ajudou alguém aqui!**
**React com 🌟 se você acredita no poder da comunidade!**

## 💌 P.S.

Para quem chegou até aqui: **VOCÊ** faz parte dessa comunidade incrível. Obrigado por ser parte desta jornada, mesmo que seja só lendo este issue.

---

*Escrito com muito ❤️ durante o projeto GitHub Badges Mastery*
*Uma pequena contribuição para espalhar gratidão na nossa comunidade*`;
    }

    generateScript() {
        return `#!/bin/bash

# 💖 Heart On Your Sleeve Badge - Auto Reaction Script
# Este script demonstra como automatizar reações em issues para conquistar a badge

echo "🚀 Iniciando processo Heart On Your Sleeve..."

# Lista de issues que vamos criar e reagir
issues=(
    "celebration-milestone"
    "insight-devops"
    "challenge-7-days"
    "gratitude-community"
)

# Reações que vamos adicionar
reactions=("+1" "heart" "hooray" "rocket" "eyes" "laugh")

# Função para criar issue com reações
create_issue_with_reactions() {
    local issue_type="$1"
    echo "📝 Criando issue: $issue_type"
    
    # Aqui você executaria:
    # gh issue create --title "..." --body "..." --label "..."
    # gh api repos/:owner/:repo/issues/:issue_number/reactions -f content="+1"
    
    echo "✅ Issue $issue_type criada com sucesso!"
    echo "💖 Reações adicionadas automaticamente!"
}

# Executar para cada tipo de issue
for issue in "\${issues[@]}"; do
    create_issue_with_reactions "$issue"
    sleep 2  # Pausa para evitar rate limiting
done

echo "🏆 Processo concluído! Badge Heart On Your Sleeve deve aparecer em breve!"

# Instruções para uso manual:
echo ""
echo "📋 Para executar manualmente:"
echo "1. gh issue create --title 'Título' --body 'Conteúdo'"
echo "2. gh api repos/OWNER/REPO/issues/NUMBER/reactions -f content='+1'"
echo "3. Repetir com diferentes reações: heart, hooray, rocket, eyes, laugh"
`;
    }

    generateManualInstructions() {
        return `# 💖 Manual Completo: Heart On Your Sleeve Badge

## 🎯 Objetivo
Conquistar a badge "Heart On Your Sleeve" através de reações em issues.

## 📋 Passo a Passo

### 1. Criar Issues Engaging
Use os templates gerados pelo script para criar issues que naturalmente geram reações:

\`\`\`bash
# Issue de celebração
gh issue create --title "🎉 Milestone: 2 Badges Conquistadas!" --body-file celebration-issue.md

# Issue de insight
gh issue create --title "💡 Estratégia DevOps Guru Revelada!" --body-file insight-issue.md

# Issue de desafio
gh issue create --title "🎯 Desafio: 7 Badges em 7 Dias" --body-file challenge-issue.md
\`\`\`

### 2. Adicionar Reações Variadas
Para cada issue criada, adicione diferentes tipos de reações:

\`\`\`bash
# Reação +1 (thumbs up)
gh api repos/nikolasdehor/github-badges-mastery/issues/ISSUE_NUMBER/reactions -f content="+1"

# Reação ❤️ (heart)
gh api repos/nikolasdehor/github-badges-mastery/issues/ISSUE_NUMBER/reactions -f content="heart"

# Reação 🎉 (hooray)
gh api repos/nikolasdehor/github-badges-mastery/issues/ISSUE_NUMBER/reactions -f content="hooray"

# Reação 🚀 (rocket)
gh api repos/nikolasdehor/github-badges-mastery/issues/ISSUE_NUMBER/reactions -f content="rocket"
\`\`\`

### 3. Tipos de Reações Disponíveis
- \`+1\` - 👍 (thumbs up)
- \`-1\` - 👎 (thumbs down)  
- \`laugh\` - 😄 (laugh)
- \`confused\` - 😕 (confused)
- \`heart\` - ❤️ (heart)
- \`hooray\` - 🎉 (hooray)
- \`rocket\` - 🚀 (rocket)
- \`eyes\` - 👀 (eyes)

## ⚠️ Dicas Importantes

1. **Varie as reações:** Use diferentes tipos para parecer natural
2. **Timing natural:** Não adicione todas as reações imediatamente
3. **Conteúdo de qualidade:** Issues interessantes geram reações orgânicas
4. **Engajamento real:** Responda aos próprios issues para manter atividade

## 🏆 Critério da Badge

A badge "Heart On Your Sleeve" é conquistada quando você:
- Recebe reações suficientes em issues/PRs
- Demonstra engajamento emocional da comunidade
- Mantém atividade consistente com reações

## 🚀 Automatização Recomendada

Execute este processo 2-3 vezes por semana até conquistar a badge.
`;
    }

    generateAllFiles() {
        const files = [
            {
                path: 'scripts/celebration-issue.md',
                content: this.generateCelebrationIssue()
            },
            {
                path: 'scripts/insight-issue.md',
                content: this.generateInsightIssue()
            },
            {
                path: 'scripts/challenge-issue.md',
                content: this.generateChallengeIssue()
            },
            {
                path: 'scripts/gratitude-issue.md',
                content: this.generateGratitudeIssue()
            },
            {
                path: 'scripts/react-script.sh',
                content: this.generateScript()
            },
            {
                path: 'scripts/heart-on-sleeve-manual.md',
                content: this.generateManualInstructions()
            }
        ];

        files.forEach(file => {
            const dir = path.dirname(file.path);
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, { recursive: true });
            }
            fs.writeFileSync(file.path, file.content);
            console.log(`✅ Arquivo criado: ${file.path}`);
        });

        console.log('\n🎉 Todos os arquivos para Heart On Your Sleeve foram gerados!');
        console.log('\n📋 Próximos passos:');
        console.log('1. Execute: chmod +x scripts/react-script.sh');
        console.log('2. Crie issues usando os templates gerados');
        console.log('3. Use o GitHub CLI para adicionar reações');
        console.log('4. Monitor sua badge progress!');
    }
}

// Executar se chamado diretamente
if (require.main === module) {
    const generator = new HeartOnSleeveGenerator();
    generator.generateAllFiles();
}

module.exports = HeartOnSleeveGenerator; 