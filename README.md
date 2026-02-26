# GitHub Badges Mastery

Repositorio dedicado para conquistar sistematicamente todas as insignias (badges) do GitHub.

## Status das Badges

| Badge | Status | Criterio Real | Como Conseguir |
|-------|--------|---------------|----------------|
| Pull Shark | **Conquistada** | 2+ PRs merged em repositorio de outra pessoa | PRs aceitos em repos de terceiros |
| Quickdraw | **Conquistada** | Fechar issue/PR em <5min | Issue #4 fechada em <5min |
| Pair Extraordinaire | Em progresso | PR merged com commits co-autorados | Commit com `Co-authored-by` em PR merged |
| YOLO | Em progresso | Merge de PR sem code review | Criar PR e merge sem review |
| Galaxy Brain | Pendente | 2 respostas aceitas em Discussions | Habilitar Discussions e responder perguntas |
| Heart On Your Sleeve | Pendente | Reagir em Discussion posts | Habilitar Discussions e reagir a posts |
| DevOps Guru | Em progresso | Workflow reutilizado por outro repo | Publicar GitHub Action reutilizavel |

**Progresso: 2/7 conquistadas (29%)**

## Detalhes de Cada Badge

### Pull Shark - Conquistada

- **Criterio:** Ter pull requests aceitos (merged) em repositorios de outros usuarios
- **Tiers:** Bronze (2), Silver (16), Gold (128), Diamond (1024)
- **Status:** Bronze conquistado com PRs merged

### Quickdraw - Conquistada

- **Criterio:** Fechar um issue ou PR em menos de 5 minutos apos abri-lo
- **Status:** Conquistada via issue #4

### Pair Extraordinaire - Em Progresso

- **Criterio:** Ter um PR merged que contenha commits com `Co-authored-by` no trailer
- **Tiers:** Bronze (1), Silver (10), Gold (24), Diamond (48)
- **Proximo passo:** Fazer merge de PR com commits co-autorados neste repo
- **Formato do trailer:**
  ```
  Co-authored-by: Nome <email@example.com>
  ```

### YOLO - Em Progresso

- **Criterio:** Fazer merge de um PR sem nenhum review
- **Proximo passo:** Criar PR e mergear imediatamente sem review
- **Nota:** Funciona apenas se o repo nao exigir review obrigatorio

### Galaxy Brain - Pendente

- **Criterio:** Ter 2 respostas marcadas como "Accepted Answer" em GitHub Discussions
- **Tiers:** Bronze (2), Silver (8), Gold (16), Diamond (32)
- **Prerequisito:** Habilitar GitHub Discussions em Settings > General > Features
- **Proximo passo:**
  1. Ir em Settings > General > Features > marcar "Discussions"
  2. Criar uma Discussion do tipo Q&A
  3. Responder e marcar como "Accepted Answer"

### Heart On Your Sleeve - Pendente

- **Criterio:** Reagir com emoji a posts em GitHub Discussions
- **Prerequisito:** GitHub Discussions habilitado
- **Proximo passo:** Reagir a Discussion posts com emojis

### DevOps Guru - Em Progresso

- **Criterio:** Ter um workflow GitHub Actions que seja reutilizado por outro repositorio
- **Proximo passo:** Publicar uma GitHub Action reutilizavel ou ter workflow adotado
- **Nota:** 8 workflows locais estao configurados, mas a badge exige uso externo

## Estrutura do Projeto

```
github-badges-mastery/
├── .github/
│   ├── workflows/           # 8 GitHub Actions workflows
│   ├── ISSUE_TEMPLATE/      # Templates para issues
│   └── DISCUSSION_TEMPLATE/ # Templates para discussions
├── src/
│   └── index.js             # Badge tracker principal
├── tests/
│   └── index.test.js        # 18 testes unitarios
├── scripts/                 # Scripts de automacao
├── docs/                    # Documentacao detalhada
└── package.json
```

## Como Usar

```bash
# Ver status das badges
npm start

# Rodar testes (18 testes)
npm test

# Build
npm run build
```

## Workflows Disponiveis

| Workflow | Comando | Proposito |
|----------|---------|-----------|
| CI/CD Pipeline | `gh workflow run ci.yml` | Testes + build |
| YOLO Merge | `gh workflow run yolo-merge.yml` | Merge direto sem review |
| Quickdraw Issues | `gh workflow run quickdraw-issues.yml` | Criar issues automaticamente |
| Pair Programming | `gh workflow run pair-programming.yml` | Commits co-autorados |
| Badge Monitor | `gh workflow run badge-monitor.yml` | Monitorar progresso |

## Acoes Manuais Necessarias

Algumas badges precisam de acoes manuais no GitHub:

1. **Galaxy Brain + Heart On Your Sleeve:** Habilitar Discussions em Settings > General > Features
2. **YOLO:** Desabilitar branch protection rules (se houver) para permitir merge sem review
3. **Pair Extraordinaire:** Fazer merge do PR com commits co-autorados
4. **DevOps Guru:** Publicar workflow como GitHub Action reutilizavel

## Licenca

MIT
