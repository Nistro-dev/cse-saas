module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // Nouvelle fonctionnalité
        'fix',      // Correction de bug
        'docs',     // Documentation
        'style',    // Formatage, indentation, etc.
        'refactor', // Refactoring
        'perf',     // Amélioration des performances
        'test',     // Tests
        'build',    // Build system, dependencies
        'ci',       // CI/CD
        'chore',    // Maintenance, tâches diverses
        'revert',   // Revert d'un commit précédent
      ],
    ],
    'subject-max-length': [2, 'always', 100],
    'subject-case': [2, 'always', 'lower-case'],
  },
};
