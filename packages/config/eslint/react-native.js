module.exports = {
  extends: [
    './base.js',
    '@react-native',
  ],
  rules: {
    // React Native specific rules
    'react-native/no-inline-styles': 'warn',
    'react-native/no-color-literals': 'warn',
  },
};
