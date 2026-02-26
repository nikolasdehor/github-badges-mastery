#!/usr/bin/env node
/**
 * 🏆 Advanced Badge Monitoring System
 * Real-time GitHub badge status checker and automation trigger
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

class BadgeMonitor {
  constructor() {
    this.version = '2.0.0';
    this.githubCLIPath = this.findGitHubCLI();
    this.badges = {
      'pair-extraordinaire': {
        name: '👥 Pair Extraordinaire',
        strategy: 'commit-coauthor',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'devops-guru': {
        name: '⚙️ DevOps Guru',
        strategy: 'github-actions',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'quickdraw': {
        name: '⚡ Quickdraw',
        strategy: 'rapid-issues',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'heart-on-sleeve': {
        name: '❤️ Heart On Your Sleeve',
        strategy: 'issue-reactions',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'yolo': {
        name: '🎲 YOLO',
        strategy: 'merge-without-review',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'pull-shark': {
        name: '🦈 Pull Shark',
        strategy: 'multiple-prs',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      },
      'galaxy-brain': {
        name: '🧠 Galaxy Brain',
        strategy: 'accepted-discussions',
        status: 'unknown',
        acquired: false,
        lastCheck: null
      }
    };
  }

  log(message, type = 'info') {
    const colors = {
      info: '\x1b[36m',    // Cyan
      success: '\x1b[32m', // Green
      warning: '\x1b[33m', // Yellow
      error: '\x1b[31m',   // Red
      reset: '\x1b[0m'
    };
    
    const timestamp = new Date().toISOString();
    console.log(`${colors[type]}[${timestamp}] ${message}${colors.reset}`);
  }

  findGitHubCLI() {
    const possiblePaths = [
      'C:\\Program Files\\GitHub CLI\\gh.exe',
      'C:\\Program Files (x86)\\GitHub CLI\\gh.exe',
      'gh' // Fallback se estiver no PATH
    ];

    for (const ghPath of possiblePaths) {
      try {
        execSync(`"${ghPath}" --version`, { stdio: 'pipe' });
        this.log(`✅ GitHub CLI found at: ${ghPath}`, 'success');
        return ghPath;
      } catch (error) {
        continue;
      }
    }

    this.log('❌ GitHub CLI not found. Install with: winget install GitHub.cli', 'error');
    return null;
  }

  async checkGitHubCLI() {
    if (!this.githubCLIPath) {
      this.log('❌ GitHub CLI not found. Install with: winget install GitHub.cli', 'error');
      return false;
    }

    try {
      execSync(`"${this.githubCLIPath}" --version`, { stdio: 'pipe' });
      this.log('✅ GitHub CLI is available', 'success');
      return true;
    } catch (error) {
      this.log('❌ GitHub CLI not working properly', 'error');
      return false;
    }
  }

  async checkAuthentication() {
    if (!this.githubCLIPath) {
      this.log('❌ GitHub CLI not found', 'error');
      return false;
    }

    try {
      execSync(`"${this.githubCLIPath}" auth status`, { stdio: 'pipe' });
      this.log('✅ GitHub CLI authenticated', 'success');
      return true;
    } catch (error) {
      this.log(`❌ GitHub CLI not authenticated. Run: "${this.githubCLIPath}" auth login`, 'error');
      return false;
    }
  }

  async checkRepositoryActivity() {
    this.log('🔍 Checking repository activity...', 'info');
    
    try {
      // Check recent commits for Pair Extraordinaire
      const commits = execSync('git log --oneline --since="1 week ago" --grep="Co-authored-by"', { 
        encoding: 'utf8',
        stdio: 'pipe' 
      });
      
      if (commits.trim()) {
        this.badges['pair-extraordinaire'].status = 'likely-acquired';
        this.badges['pair-extraordinaire'].acquired = true;
        this.log('✅ Pair Extraordinaire: Co-authored commits found', 'success');
      } else {
        this.badges['pair-extraordinaire'].status = 'needs-action';
        this.log('⚠️ Pair Extraordinaire: No co-authored commits found', 'warning');
      }
    } catch (error) {
      this.log('⚠️ Could not check commit history', 'warning');
    }

    if (!this.githubCLIPath) {
      this.log('⚠️ Skipping GitHub API checks - GitHub CLI not found', 'warning');
      return;
    }

    try {
      // Check GitHub Actions workflows for DevOps Guru
      const runs = execSync(`"${this.githubCLIPath}" run list --limit 10 --json status,conclusion`, { 
        encoding: 'utf8',
        stdio: 'pipe' 
      });
      
      const runData = JSON.parse(runs);
      const successfulRuns = runData.filter(run => run.conclusion === 'success');
      
      if (successfulRuns.length >= 3) {
        this.badges['devops-guru'].status = 'likely-acquired';
        this.badges['devops-guru'].acquired = true;
        this.log('✅ DevOps Guru: Multiple successful workflow runs found', 'success');
      } else {
        this.badges['devops-guru'].status = 'needs-action';
        this.log('⚠️ DevOps Guru: Need more successful workflow runs', 'warning');
      }
    } catch (error) {
      this.log('⚠️ Could not check workflow runs', 'warning');
    }

    try {
      // Check recent issues for Quickdraw
      const issues = execSync(`"${this.githubCLIPath}" issue list --limit 5 --json createdAt,reactions`, { 
        encoding: 'utf8',
        stdio: 'pipe' 
      });
      
      const issueData = JSON.parse(issues);
      const recentIssues = issueData.filter(issue => {
        const created = new Date(issue.createdAt);
        const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
        return created > fiveMinutesAgo;
      });

      if (recentIssues.length > 0) {
        this.badges['quickdraw'].status = 'likely-acquired';
        this.badges['quickdraw'].acquired = true;
        this.log('✅ Quickdraw: Recent rapid issues found', 'success');
        
        // Check for Heart On Your Sleeve (reactions)
        const hasReactions = issueData.some(issue => 
          issue.reactions && Object.keys(issue.reactions).length > 0
        );
        
        if (hasReactions) {
          this.badges['heart-on-sleeve'].status = 'likely-acquired';
          this.badges['heart-on-sleeve'].acquired = true;
          this.log('✅ Heart On Your Sleeve: Issue reactions found', 'success');
        }
      } else {
        this.badges['quickdraw'].status = 'needs-action';
        this.log('⚠️ Quickdraw: No recent rapid issues found', 'warning');
      }
    } catch (error) {
      this.log('⚠️ Could not check issues', 'warning');
    }

    try {
      // Check recent PRs for Pull Shark and YOLO
      const prs = execSync(`"${this.githubCLIPath}" pr list --state merged --limit 10 --json mergedAt,reviews`, { 
        encoding: 'utf8',
        stdio: 'pipe' 
      });
      
      const prData = JSON.parse(prs);
      const recentPRs = prData.filter(pr => {
        const merged = new Date(pr.mergedAt);
        const oneWeek = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
        return merged > oneWeek;
      });

      if (recentPRs.length >= 2) {
        this.badges['pull-shark'].status = 'likely-acquired';
        this.badges['pull-shark'].acquired = true;
        this.log('✅ Pull Shark: Multiple merged PRs found', 'success');
      }

      // Check for YOLO (PRs merged without reviews)
      const yoloPRs = recentPRs.filter(pr => 
        !pr.reviews || pr.reviews.length === 0
      );

      if (yoloPRs.length > 0) {
        this.badges['yolo'].status = 'likely-acquired';
        this.badges['yolo'].acquired = true;
        this.log('✅ YOLO: PRs merged without review found', 'success');
      }
    } catch (error) {
      this.log('⚠️ Could not check pull requests', 'warning');
    }

    // Update last check timestamp
    Object.keys(this.badges).forEach(key => {
      this.badges[key].lastCheck = new Date().toISOString();
    });
  }

  async checkDiscussions() {
    if (!this.githubCLIPath) {
      this.log('⚠️ Cannot check discussions - GitHub CLI not found', 'warning');
      return;
    }

    try {
      // Check if discussions are enabled
      const repoInfo = execSync(`"${this.githubCLIPath}" api repos/:owner/:repo --jq .has_discussions`, { 
        encoding: 'utf8',
        stdio: 'pipe' 
      });
      
      if (repoInfo.trim() === 'true') {
        this.badges['galaxy-brain'].status = 'discussions-enabled';
        this.log('✅ Galaxy Brain: Discussions are enabled', 'success');
        
        // TODO: Check for accepted discussions when API supports it
        this.log('ℹ️ Galaxy Brain: Manual verification needed for accepted discussions', 'info');
      } else {
        this.badges['galaxy-brain'].status = 'discussions-disabled';
        this.log('⚠️ Galaxy Brain: Discussions need to be enabled', 'warning');
      }
    } catch (error) {
      this.log('⚠️ Could not check discussions status', 'warning');
    }
  }

  generateReport() {
    this.log('\n🏆 BADGE STATUS REPORT', 'info');
    this.log('==========================================', 'info');
    
    let acquiredCount = 0;
    let totalCount = Object.keys(this.badges).length;
    
    Object.entries(this.badges).forEach(([key, badge]) => {
      const status = badge.acquired ? '✅ ACQUIRED' : 
                    badge.status === 'likely-acquired' ? '🟡 LIKELY' :
                    badge.status === 'needs-action' ? '❌ NEEDS ACTION' :
                    badge.status === 'discussions-enabled' ? '🔄 READY' :
                    '❓ UNKNOWN';
      
      this.log(`${badge.name}: ${status}`, badge.acquired ? 'success' : 'warning');
      
      if (badge.acquired) acquiredCount++;
    });
    
    this.log('\n📊 SUMMARY', 'info');
    this.log(`Progress: ${acquiredCount}/${totalCount} badges`, 'info');
    this.log(`Success Rate: ${Math.round((acquiredCount/totalCount) * 100)}%`, 'info');
    
    return {
      total: totalCount,
      acquired: acquiredCount,
      rate: Math.round((acquiredCount/totalCount) * 100),
      badges: this.badges
    };
  }

  async suggestActions() {
    this.log('\n🎯 SUGGESTED ACTIONS', 'info');
    this.log('==========================================', 'info');
    
    Object.entries(this.badges).forEach(([key, badge]) => {
      if (!badge.acquired) {
        switch (key) {
          case 'pair-extraordinaire':
            this.log('👥 Run: git commit with Co-authored-by lines', 'warning');
            break;
          case 'devops-guru':
            this.log(`⚙️ Run: "${this.githubCLIPath}" workflow run ci.yml`, 'warning');
            break;
          case 'quickdraw':
            this.log(`⚡ Run: "${this.githubCLIPath}" workflow run quickdraw-issues.yml`, 'warning');
            break;
          case 'heart-on-sleeve':
            this.log('❤️ Add reactions to recent issues manually or via API', 'warning');
            break;
          case 'yolo':
            this.log(`🎲 Run: "${this.githubCLIPath}" workflow run yolo-merge.yml`, 'warning');
            break;
          case 'pull-shark':
            this.log(`🦈 Run: "${this.githubCLIPath}" workflow run pull-shark-automated.yml`, 'warning');
            break;
          case 'galaxy-brain':
            if (badge.status === 'discussions-disabled') {
              this.log('🧠 Enable Discussions in repository settings', 'warning');
            } else {
              this.log('🧠 Create and get accepted discussions', 'warning');
            }
            break;
        }
      }
    });
  }

  async executeAutomation(dryRun = false) {
    this.log('\n🤖 EXECUTING AUTOMATION', 'info');
    this.log('==========================================', 'info');
    
    if (!this.githubCLIPath) {
      this.log('❌ Cannot execute automation - GitHub CLI not found', 'error');
      return;
    }
    
    if (dryRun) {
      this.log('🔍 DRY RUN MODE - No actions will be executed', 'warning');
    }
    
    const actions = [];
    
    // Pair Extraordinaire
    if (!this.badges['pair-extraordinaire'].acquired) {
      actions.push({
        badge: 'pair-extraordinaire',
        command: 'MASTER-BADGE-AUTOMATION.ps1 -BadgeTarget PairExtraordinaire'
      });
    }
    
    // DevOps Guru
    if (!this.badges['devops-guru'].acquired) {
      actions.push({
        badge: 'devops-guru',
        command: `"${this.githubCLIPath}" workflow run ci.yml`
      });
    }
    
    // Quickdraw + Heart
    if (!this.badges['quickdraw'].acquired || !this.badges['heart-on-sleeve'].acquired) {
      actions.push({
        badge: 'quickdraw-heart',
        command: `"${this.githubCLIPath}" workflow run quickdraw-issues.yml`
      });
    }
    
    // YOLO
    if (!this.badges['yolo'].acquired) {
      actions.push({
        badge: 'yolo',
        command: `"${this.githubCLIPath}" workflow run yolo-merge.yml`
      });
    }
    
    // Pull Shark
    if (!this.badges['pull-shark'].acquired) {
      actions.push({
        badge: 'pull-shark',
        command: `"${this.githubCLIPath}" workflow run pull-shark-automated.yml`
      });
    }
    
    if (actions.length === 0) {
      this.log('🎉 All automatable badges appear to be acquired!', 'success');
      return;
    }
    
    for (const action of actions) {
      this.log(`🚀 Executing: ${action.command}`, 'info');
      
      if (!dryRun) {
        try {
          execSync(action.command, { stdio: 'inherit' });
          this.log(`✅ Successfully executed ${action.badge} automation`, 'success');
        } catch (error) {
          this.log(`❌ Failed to execute ${action.badge}: ${error.message}`, 'error');
        }
        
        // Wait between actions to avoid rate limiting
        await this.sleep(3000);
      }
    }
  }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async saveReport(filename = null) {
    const reportData = {
      timestamp: new Date().toISOString(),
      version: this.version,
      badges: this.badges,
      summary: this.generateReport()
    };
    
    const reportFile = filename || `badge-report-${new Date().toISOString().split('T')[0]}.json`;
    
    try {
      fs.writeFileSync(reportFile, JSON.stringify(reportData, null, 2));
      this.log(`📁 Report saved to: ${reportFile}`, 'success');
    } catch (error) {
      this.log(`❌ Failed to save report: ${error.message}`, 'error');
    }
  }
}

// CLI Interface
async function main() {
  const args = process.argv.slice(2);
  const monitor = new BadgeMonitor();
  
  console.log('🏆 GitHub Badge Monitor v' + monitor.version);
  console.log('=========================================\n');
  
  // Check prerequisites
  if (!(await monitor.checkGitHubCLI())) return;
  if (!(await monitor.checkAuthentication())) return;
  
  // Check repository activity
  await monitor.checkRepositoryActivity();
  await monitor.checkDiscussions();
  
  // Generate report
  const report = monitor.generateReport();
  
  // Handle CLI arguments
  if (args.includes('--suggest') || args.includes('-s')) {
    await monitor.suggestActions();
  }
  
  if (args.includes('--automate') || args.includes('-a')) {
    const dryRun = args.includes('--dry-run') || args.includes('-d');
    await monitor.executeAutomation(dryRun);
  }
  
  if (args.includes('--save') || args.includes('-o')) {
    await monitor.saveReport();
  }
  
  if (report.acquired === report.total) {
    console.log('\n🎉 CONGRATULATIONS! All badges appear to be acquired!');
    console.log('🔗 Check your profile: https://github.com/settings/profile');
  }
}

// Run if called directly
if (require.main === module) {
  main().catch(error => {
    console.error('❌ Error:', error.message);
    process.exit(1);
  });
}

module.exports = BadgeMonitor;