module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // New feature
        'fix',      // Bug fix
        'docs',     // Documentation changes
        'style',    // Code style changes (formatting, etc.)
        'refactor', // Code refactoring
        'perf',     // Performance improvements
        'test',     // Adding or updating tests
        'chore',    // Maintenance tasks
        'ci',       // CI/CD changes
        'build',    // Build system changes
        'revert',   // Reverting changes
      ],
    ],
    'scope-enum': [
      2,
      'always',
      [
        'api',      // Backend API changes
        'web',      // Web application changes
        'mobile',   // Mobile application changes
        'contracts', // Smart contracts changes
        'ui',       // Shared UI components
        'config',   // Configuration changes
        'sdk',      // SDK changes
        'infra',    // Infrastructure changes
        'deps',     // Dependency updates
        'docs',     // Documentation
      ],
    ],
    'subject-case': [2, 'never', ['sentence-case', 'start-case', 'pascal-case', 'upper-case']],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'header-max-length': [2, 'always', 100],
  },
};
