module.exports = {
  extends: [
    './base.js',
    'next/core-web-vitals',
  ],
  rules: {
    // Next.js specific rules
    '@next/next/no-html-link-for-pages': 'off',
    'react/no-unescaped-entities': 'off',
  },
};
