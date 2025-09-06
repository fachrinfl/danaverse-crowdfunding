# 🛠️ Code Quality Tools - DanaVerse

## 📋 **Overview**

DanaVerse menggunakan berbagai code quality tools untuk memastikan kode yang konsisten, aman, dan berkualitas tinggi di seluruh monorepo.

---

## 🔧 **Tools by Language**

### **TypeScript/JavaScript**

```bash
# Formatting & Linting
eslint --fix .                # Fix linting issues
prettier --write .            # Format code

# Type Checking
tsc --noEmit                  # TypeScript type checking

# Testing
jest                          # Unit testing
```

### **Go**

```bash
# Code Formatting
gofmt -w .                    # Format Go files
goimports -w .                # Format + organize imports

# Code Analysis
go vet ./...                  # Static analysis
golangci-lint run             # Comprehensive linting
gosec ./...                   # Security analysis

# Testing
go test ./...                 # Run tests
go test -race ./...           # Race condition testing
go test -cover ./...          # Coverage testing
```

### **Solidity**

```bash
# Code Formatting
prettier --write "**/*.sol"   # Format Solidity files

# Linting
solhint "contracts/**/*.sol"  # Solidity linter
slither .                     # Static analysis

# Testing
forge test                    # Foundry testing
forge coverage                # Coverage testing

# Security
mythril analyze .             # Security analysis
echidna-test .                # Fuzz testing
```

### **Shell Scripts**

```bash
# Code Formatting
shfmt -w .                    # Format shell scripts
beautysh .                    # Alternative formatter

# Linting
shellcheck .                  # Shell script linter
bashate .                     # Bash style guide

# Testing
bats .                        # Bash testing framework
```

### **Terraform**

```bash
# Code Formatting
terraform fmt -recursive      # Format Terraform files

# Linting
tflint .                      # Terraform linter
tfsec .                       # Security analysis
checkov .                     # Security & compliance

# Validation
terraform validate            # Validate configuration
terraform plan                # Plan changes
```

---

## 🚀 **Installation**

### **Install All Tools**

```bash
pnpm linters:install
```

### **Install by Language**

```bash
# Go tools
pnpm linters:install:go

# Solidity tools
pnpm linters:install:solidity

# Shell tools
pnpm linters:install:shell

# Terraform tools
pnpm linters:install:terraform
```

### **Check Installed Tools**

```bash
pnpm linters:check
```

---

## 🔄 **Husky Integration**

### **Pre-commit Hook (lint-staged)**

```json
{
  "*.{ts,tsx,js,jsx}": ["eslint --fix", "prettier --write"],
  "*.{json,md,yml,yaml}": ["prettier --write"],
  "*.go": ["gofmt -w", "goimports -w"],
  "*.sol": ["prettier --write", "solhint --fix"],
  "*.sh": ["shfmt -w", "shellcheck"],
  "*.tf": ["terraform fmt -recursive", "tflint"]
}
```

### **Coverage Summary**

| Language              | Pre-commit                | Commit-msg | Status   |
| --------------------- | ------------------------- | ---------- | -------- |
| TypeScript/JavaScript | ✅ ESLint + Prettier      | ✅         | Complete |
| JSON                  | ✅ Prettier               | ✅         | Complete |
| Markdown              | ✅ Prettier               | ✅         | Complete |
| YAML                  | ✅ Prettier               | ✅         | Complete |
| Go                    | ✅ gofmt + goimports      | ✅         | Complete |
| Solidity              | ✅ Prettier + solhint     | ✅         | Complete |
| Shell Scripts         | ✅ shfmt + shellcheck     | ✅         | Complete |
| Terraform             | ✅ terraform fmt + tflint | ✅         | Complete |

---

## 📝 **Usage Examples**

### **Manual Formatting**

```bash
# Format all files
pnpm format

# Format specific language
gofmt -w apps/api/
prettier --write "contracts/**/*.sol"
shfmt -w scripts/
terraform fmt -recursive infra/
```

### **Manual Linting**

```bash
# Lint all files
pnpm lint

# Lint specific language
golangci-lint run apps/api/
solhint "contracts/**/*.sol"
shellcheck scripts/
tflint infra/
```

### **Testing**

```bash
# Test all
pnpm test

# Test specific language
go test ./apps/api/...
forge test
bats scripts/
terraform validate
```

---

## 🔧 **Configuration Files**

### **ESLint** (`.eslintrc.js`)

```javascript
module.exports = {
  extends: ['@danaverse/config/eslint/nextjs'],
  root: true,
};
```

### **Prettier** (`.prettierrc.js`)

```javascript
module.exports = require('@danaverse/config/prettier');
```

### **Commitlint** (`commitlint.config.js`)

```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'chore',
        'ci',
        'build',
        'revert',
      ],
    ],
    'scope-enum': [
      2,
      'always',
      [
        'api',
        'web',
        'mobile',
        'contracts',
        'ui',
        'config',
        'sdk',
        'infra',
        'deps',
        'docs',
      ],
    ],
  },
};
```

### **Solhint** (`.solhint.json`)

```json
{
  "extends": "solhint:recommended",
  "rules": {
    "compiler-version": ["error", "^0.8.0"],
    "func-visibility": ["warn", { "ignoreConstructors": true }]
  }
}
```

### **TFLint** (`.tflint.hcl`)

```hcl
plugin "aws" {
  enabled = true
  version = "0.21.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
```

---

## 🧪 **Testing Strategy**

### **Unit Tests**

- **TypeScript/JavaScript**: Jest
- **Go**: Built-in testing
- **Solidity**: Foundry testing
- **Shell**: Bats
- **Terraform**: Terratest

### **Integration Tests**

- **API**: Go integration tests
- **Smart Contracts**: Foundry integration tests
- **Infrastructure**: Terratest

### **E2E Tests**

- **Web**: Playwright
- **Mobile**: Detox
- **API**: Postman/Newman

---

## 🔒 **Security Tools**

### **Static Analysis**

- **Go**: gosec, golangci-lint
- **Solidity**: slither, mythril
- **Terraform**: tfsec, checkov
- **JavaScript**: ESLint security rules

### **Dependency Scanning**

- **npm**: npm audit
- **Go**: go list -json -m all
- **Terraform**: checkov

---

## 📊 **Quality Metrics**

### **Code Coverage**

- **Target**: 80% minimum
- **Tools**: Jest, go test, forge coverage

### **Performance**

- **Web**: Lighthouse, Web Vitals
- **API**: Go benchmarks
- **Smart Contracts**: Gas optimization

### **Security**

- **Regular audits**: Monthly
- **Dependency updates**: Weekly
- **Vulnerability scanning**: Continuous

---

## 🚀 **CI/CD Integration**

### **GitHub Actions**

```yaml
- name: Lint Code
  run: |
    pnpm lint
    golangci-lint run
    solhint "contracts/**/*.sol"
    shellcheck scripts/
    tflint infra/

- name: Format Check
  run: |
    pnpm format:check
    gofmt -d .
    terraform fmt -check -recursive
```

### **Pre-commit Hooks**

- Automatic formatting
- Linting checks
- Type checking
- Security scanning

---

## 🆘 **Troubleshooting**

### **Common Issues**

1. **Tool not found**

   ```bash
   # Install missing tool
   pnpm linters:install
   ```

2. **Format conflicts**

   ```bash
   # Reset formatting
   pnpm format
   ```

3. **Lint errors**
   ```bash
   # Fix auto-fixable issues
   pnpm lint --fix
   ```

### **Getting Help**

- Check tool documentation
- Run `pnpm linters:examples`
- Check GitHub Issues
- Ask in team chat

---

**Status: All code quality tools configured and ready! 🚀**
