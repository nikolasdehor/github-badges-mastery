const {
    BADGE_DEFINITIONS,
    getBadges,
    calculateProgress,
    generateStatusReport,
    getBadgeById,
    getCompletedBadges,
    getPendingBadges
} = require('../src/index.js');

let passed = 0;
let failed = 0;

function assert(condition, message) {
    if (!condition) {
        throw new Error(message);
    }
}

function test(name, fn) {
    try {
        fn();
        passed++;
        console.log(`  PASS: ${name}`);
    } catch (error) {
        failed++;
        console.error(`  FAIL: ${name} - ${error.message}`);
    }
}

console.log('Running tests...\n');

// getBadges tests
test('getBadges returns array of 7 badges', () => {
    const badges = getBadges();
    assert(Array.isArray(badges), 'Should return an array');
    assert(badges.length === 7, `Expected 7 badges, got ${badges.length}`);
});

test('getBadges returns copies (not references)', () => {
    const badges1 = getBadges();
    const badges2 = getBadges();
    badges1[0].name = 'modified';
    assert(badges2[0].name !== 'modified', 'Should return independent copies');
});

test('each badge has required fields', () => {
    const required = ['id', 'name', 'criteria', 'strategy', 'status', 'tier', 'tiers'];
    const badges = getBadges();
    badges.forEach(badge => {
        required.forEach(field => {
            assert(field in badge, `Badge "${badge.name}" missing field "${field}"`);
        });
    });
});

test('badge statuses are valid values', () => {
    const validStatuses = ['completed', 'in-progress', 'pending'];
    getBadges().forEach(badge => {
        assert(validStatuses.includes(badge.status),
            `Badge "${badge.name}" has invalid status "${badge.status}"`);
    });
});

// calculateProgress tests
test('calculateProgress returns correct structure', () => {
    const progress = calculateProgress();
    assert(typeof progress.total === 'number', 'total should be number');
    assert(typeof progress.completed === 'number', 'completed should be number');
    assert(typeof progress.inProgress === 'number', 'inProgress should be number');
    assert(typeof progress.pending === 'number', 'pending should be number');
    assert(typeof progress.percentage === 'number', 'percentage should be number');
});

test('calculateProgress counts add up to total', () => {
    const p = calculateProgress();
    assert(p.completed + p.inProgress + p.pending === p.total,
        'completed + inProgress + pending should equal total');
});

test('calculateProgress percentage is between 0 and 100', () => {
    const p = calculateProgress();
    assert(p.percentage >= 0 && p.percentage <= 100,
        `Percentage ${p.percentage} should be between 0 and 100`);
});

test('calculateProgress with custom badges', () => {
    const custom = [
        { status: 'completed' },
        { status: 'completed' },
        { status: 'pending' }
    ];
    const p = calculateProgress(custom);
    assert(p.total === 3, 'Total should be 3');
    assert(p.completed === 2, 'Completed should be 2');
    assert(p.percentage === 67, `Percentage should be 67, got ${p.percentage}`);
});

// generateStatusReport tests
test('generateStatusReport returns valid report', () => {
    const report = generateStatusReport();
    assert(report.timestamp, 'Should have timestamp');
    assert(report.project === 'GitHub Badges Mastery', 'Project name should match');
    assert(report.version === '2.0.0', 'Version should be 2.0.0');
    assert(report.progress, 'Should have progress');
    assert(Array.isArray(report.badges), 'badges should be array');
    assert(Array.isArray(report.nextSteps), 'nextSteps should be array');
});

test('generateStatusReport timestamp is valid ISO date', () => {
    const report = generateStatusReport();
    const date = new Date(report.timestamp);
    assert(!isNaN(date.getTime()), 'Timestamp should be valid date');
});

test('generateStatusReport nextSteps only includes non-completed badges', () => {
    const report = generateStatusReport();
    const completedCount = report.badges.filter(b => b.status === 'completed').length;
    assert(report.nextSteps.length === report.badges.length - completedCount,
        'nextSteps should match non-completed badge count');
});

// getBadgeById tests
test('getBadgeById returns correct badge', () => {
    const badge = getBadgeById('pull-shark');
    assert(badge !== null, 'Should find pull-shark');
    assert(badge.name === 'Pull Shark', 'Name should match');
});

test('getBadgeById returns null for unknown id', () => {
    const badge = getBadgeById('nonexistent');
    assert(badge === null, 'Should return null for unknown id');
});

// getCompletedBadges / getPendingBadges tests
test('getCompletedBadges returns only completed badges', () => {
    const completed = getCompletedBadges();
    completed.forEach(b => {
        assert(b.status === 'completed', `Badge "${b.name}" should be completed`);
    });
});

test('getPendingBadges returns only non-completed badges', () => {
    const pending = getPendingBadges();
    pending.forEach(b => {
        assert(b.status !== 'completed', `Badge "${b.name}" should not be completed`);
    });
});

test('completed + pending badges equal total', () => {
    const total = getBadges().length;
    const completed = getCompletedBadges().length;
    const pending = getPendingBadges().length;
    assert(completed + pending === total,
        `${completed} + ${pending} should equal ${total}`);
});

// BADGE_DEFINITIONS integrity
test('BADGE_DEFINITIONS has unique ids', () => {
    const ids = BADGE_DEFINITIONS.map(b => b.id);
    const unique = new Set(ids);
    assert(unique.size === ids.length, 'All badge IDs should be unique');
});

test('all badges have at least bronze tier defined', () => {
    BADGE_DEFINITIONS.forEach(badge => {
        assert(badge.tiers && typeof badge.tiers.bronze === 'number',
            `Badge "${badge.name}" should have bronze tier`);
    });
});

// Summary
console.log(`\nResults: ${passed} passed, ${failed} failed, ${passed + failed} total`);
process.exit(failed > 0 ? 1 : 0);
