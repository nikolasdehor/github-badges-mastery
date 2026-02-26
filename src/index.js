// GitHub Badges Mastery - Arquivo Principal
// Projeto dedicado para conquistar todas as insignias do GitHub

const BADGE_DEFINITIONS = [
    {
        id: 'pull-shark',
        name: 'Pull Shark',
        criteria: '2+ Pull Requests merged',
        strategy: 'Criar branches tematicas e PRs estruturados',
        status: 'completed',
        tier: 'bronze',
        tiers: { bronze: 2, silver: 16, gold: 128, diamond: 1024 }
    },
    {
        id: 'pair-extraordinaire',
        name: 'Pair Extraordinaire',
        criteria: 'Co-autoria em commits via PR merged',
        strategy: 'Commits colaborativos com co-autores em PRs',
        status: 'in-progress',
        tier: null,
        tiers: { bronze: 1, silver: 10, gold: 24, diamond: 48 }
    },
    {
        id: 'devops-guru',
        name: 'DevOps Guru',
        criteria: 'GitHub Actions workflow usado por outro repo',
        strategy: 'Publicar actions reutilizaveis ou ter workflow adotado',
        status: 'in-progress',
        tier: null,
        tiers: { bronze: 1 }
    },
    {
        id: 'galaxy-brain',
        name: 'Galaxy Brain',
        criteria: 'Resposta aceita em Discussions',
        strategy: 'Habilitar Discussions e responder com qualidade',
        status: 'pending',
        tier: null,
        tiers: { bronze: 2, silver: 8, gold: 16, diamond: 32 }
    },
    {
        id: 'quickdraw',
        name: 'Quickdraw',
        criteria: 'Issue/PR fechado em menos de 5 minutos',
        strategy: 'Fechar issue ou PR rapidamente apos abrir',
        status: 'completed',
        tier: null,
        tiers: { bronze: 1 }
    },
    {
        id: 'heart-on-your-sleeve',
        name: 'Heart On Your Sleeve',
        criteria: 'Reagir com emoji em Discussions',
        strategy: 'Habilitar Discussions e reagir a posts',
        status: 'pending',
        tier: null,
        tiers: { bronze: 1 }
    },
    {
        id: 'yolo',
        name: 'YOLO',
        criteria: 'Merge de PR sem code review',
        strategy: 'Criar PR e fazer merge sem review',
        status: 'in-progress',
        tier: null,
        tiers: { bronze: 1 }
    }
];

function getBadges() {
    return BADGE_DEFINITIONS.map(b => ({ ...b }));
}

function calculateProgress(badges) {
    const list = badges || getBadges();
    const total = list.length;
    const completed = list.filter(b => b.status === 'completed').length;
    const inProgress = list.filter(b => b.status === 'in-progress').length;
    const pending = list.filter(b => b.status === 'pending').length;

    return {
        total,
        completed,
        inProgress,
        pending,
        percentage: Math.round((completed / total) * 100)
    };
}

function generateStatusReport(badges) {
    const list = badges || getBadges();
    const progress = calculateProgress(list);

    return {
        timestamp: new Date().toISOString(),
        project: 'GitHub Badges Mastery',
        version: '2.0.0',
        progress,
        badges: list,
        nextSteps: list
            .filter(b => b.status !== 'completed')
            .map(b => `${b.name}: ${b.strategy}`)
    };
}

function getBadgeById(id) {
    return BADGE_DEFINITIONS.find(b => b.id === id) || null;
}

function getCompletedBadges() {
    return BADGE_DEFINITIONS.filter(b => b.status === 'completed');
}

function getPendingBadges() {
    return BADGE_DEFINITIONS.filter(b => b.status !== 'completed');
}

function printReport() {
    const report = generateStatusReport();
    const p = report.progress;

    console.log('GitHub Badges Mastery - Status Report');
    console.log('='.repeat(45));
    console.log(`Data: ${new Date().toLocaleDateString('pt-BR')}`);
    console.log(`Progresso: ${p.completed}/${p.total} (${p.percentage}%)`);
    console.log('');

    report.badges.forEach(badge => {
        const icon = badge.status === 'completed' ? '[x]'
            : badge.status === 'in-progress' ? '[-]'
            : '[ ]';
        const tierInfo = badge.tier ? ` (${badge.tier})` : '';
        console.log(`  ${icon} ${badge.name}${tierInfo} - ${badge.criteria}`);
    });

    if (report.nextSteps.length > 0) {
        console.log('');
        console.log('Proximos passos:');
        report.nextSteps.forEach((step, i) => {
            console.log(`  ${i + 1}. ${step}`);
        });
    }

    console.log('');
    console.log(`Completadas: ${p.completed} | Em progresso: ${p.inProgress} | Pendentes: ${p.pending}`);
    return report;
}

if (require.main === module) {
    printReport();
}

module.exports = {
    BADGE_DEFINITIONS,
    getBadges,
    calculateProgress,
    generateStatusReport,
    getBadgeById,
    getCompletedBadges,
    getPendingBadges,
    printReport
};
