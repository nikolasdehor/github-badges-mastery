/**
 * 🤝 Pair Extraordinaire Demo
 * Arquivo criado especificamente para demonstrar co-autoria
 * e conquistar a badge Pair Extraordinaire
 */

class BadgeTracker {
    constructor() {
        this.badges = new Map();
        this.achievements = [];
    }

    /**
     * Adiciona uma nova badge conquistada
     * @param {string} name - Nome da badge
     * @param {Date} date - Data de conquista
     * @param {string} evidence - Evidência da conquista
     */
    addBadge(name, date, evidence) {
        const badge = {
            name,
            date: date || new Date(),
            evidence,
            timestamp: Date.now()
        };
        
        this.badges.set(name, badge);
        this.achievements.push(badge);
        
        console.log(`🏆 Badge conquistada: ${name}`);
        return badge;
    }

    /**
     * Lista todas as badges conquistadas
     */
    listAchievements() {
        console.log('🏅 Achievements Unlocked:');
        this.achievements.forEach((badge, index) => {
            console.log(`${index + 1}. ${badge.name} - ${badge.date.toLocaleDateString()}`);
        });
        return this.achievements;
    }

    /**
     * Calcula estatísticas de progresso
     */
    getProgress() {
        const totalPossible = 7; // Total de badges disponíveis
        const conquered = this.badges.size;
        const percentage = (conquered / totalPossible * 100).toFixed(1);
        
        return {
            total: totalPossible,
            conquered,
            percentage,
            remaining: totalPossible - conquered
        };
    }

    /**
     * Gera relatório de badges
     */
    generateReport() {
        const progress = this.getProgress();
        const report = `
🏆 GitHub Badges Mastery Report
===============================
📊 Progresso: ${progress.conquered}/${progress.total} (${progress.percentage}%)
⏰ Última atualização: ${new Date().toLocaleString()}

🎯 Badges Conquistadas:
${this.achievements.map(badge => `✅ ${badge.name} - ${badge.date.toLocaleDateString()}`).join('\n')}

🚀 Próximos objetivos: ${progress.remaining} badges restantes
        `;
        
        return report;
    }
}

// Instância global do tracker
const badgeTracker = new BadgeTracker();

// Registrar badges já conquistadas
badgeTracker.addBadge('Pull Shark', new Date('2025-06-23'), 'nikolasdehor/github-badges-mastery#2');
badgeTracker.addBadge('Quickdraw', new Date('2025-06-23'), 'nikolasdehor/github-badges-mastery#4');

// Exportar para uso em outros módulos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { BadgeTracker, badgeTracker };
}

// Log inicial
console.log('🚀 Badge Tracker inicializado!');
console.log(badgeTracker.generateReport()); 