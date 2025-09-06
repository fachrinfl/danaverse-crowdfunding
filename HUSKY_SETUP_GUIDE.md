# 🐕 Husky Setup Guide - DanaVerse

## 📋 **Status Husky**

### ✅ **Yang Sudah Dikonfigurasi:**

- ✅ **Husky v8.0.3** - Installed di devDependencies
- ✅ **Pre-commit hook** - `.husky/pre-commit` dengan lint-staged
- ✅ **Commit-msg hook** - `.husky/commit-msg` dengan commitlint
- ✅ **Lint-staged** - Configured untuk TypeScript/JavaScript files
- ✅ **Commitlint** - Configured dengan conventional commits
- ✅ **ESLint** - Configured dengan TypeScript rules
- ✅ **Prettier** - Configured untuk code formatting

### ⚠️ **Yang Perlu Dilakukan:**

- ❌ **Git repository** - Belum diinisialisasi
- ❌ **Husky install** - Perlu dijalankan setelah git init

---

## 🔧 **Cakupan Husky**

### **Pre-commit Hook (lint-staged):**

```json
{
  "*.{ts,tsx,js,jsx}": ["eslint --fix", "prettier --write"],
  "*.{json,md,yml,yaml}": ["prettier --write"]
}
```

**Yang Diperiksa:**

- ✅ **TypeScript/JavaScript** - ESLint + Prettier
- ✅ **JSON files** - Prettier formatting
- ✅ **Markdown files** - Prettier formatting
- ✅ **YAML files** - Prettier formatting

**Yang TIDAK Diperiksa:**

- ❌ **Go files** - Tidak ada Go linter
- ❌ **Solidity files** - Tidak ada Solidity linter
- ❌ **Shell scripts** - Tidak ada shell linter
- ❌ **Terraform files** - Tidak ada Terraform linter

### **Commit-msg Hook (commitlint):**

```javascript
// commitlint.config.js
rules: {
  'type-enum': ['feat', 'fix', 'docs', 'style', 'refactor', 'perf', 'test', 'chore', 'ci', 'build', 'revert'],
  'scope-enum': ['api', 'web', 'mobile', 'contracts', 'ui', 'config', 'sdk', 'infra', 'deps', 'docs']
}
```

**Format yang Diterima:**

- ✅ `feat(api): add user authentication`
- ✅ `fix(web): resolve mobile navigation issue`
- ✅ `docs(readme): update installation instructions`
- ✅ `chore(deps): update dependencies`

---

## 🚀 **Setup Instructions**

### **1. Initialize Git Repository**

```bash
git init
```

### **2. Install Husky**

```bash
npx husky install
```

### **3. Test Husky**

```bash
# Test pre-commit hook
echo "console.log('test');" > test.js
git add test.js
git commit -m "test: add test file"
# Should trigger lint-staged

# Test commit-msg hook
git commit -m "invalid commit message"
# Should fail with commitlint error
```

---

## 📝 **Commit Message Examples**

### ✅ **Valid Commit Messages:**

```bash
feat(api): add user authentication endpoint
fix(web): resolve mobile navigation issue
docs(readme): update installation instructions
style(mobile): format code with prettier
refactor(contracts): optimize gas usage
perf(web): improve page load time
test(api): add unit tests for auth service
chore(deps): update dependencies
ci(github): add automated testing
build(web): optimize production bundle
revert(api): revert authentication changes
```

### ❌ **Invalid Commit Messages:**

```bash
# Missing type
"add new feature"

# Invalid type
"feature(api): add new endpoint"

# Invalid scope
"feat(backend): add new endpoint"

# Too long
"feat(api): add a very long commit message that exceeds the maximum length limit"

# Sentence case
"feat(api): Add new endpoint"
```

---

## 🔧 **Troubleshooting**

### **Husky Not Working:**

```bash
# Reinstall husky
npx husky install

# Check git hooks
ls -la .git/hooks/

# Test manually
.husky/pre-commit
.husky/commit-msg
```

### **Lint-staged Not Working:**

```bash
# Check lint-staged config
npx lint-staged --help

# Test manually
npx lint-staged
```

### **Commitlint Not Working:**

```bash
# Test commit message
echo "feat(api): test message" | npx commitlint

# Check config
npx commitlint --help
```

---

## 📊 **Coverage Summary**

| File Type             | Pre-commit           | Commit-msg | Status   |
| --------------------- | -------------------- | ---------- | -------- |
| TypeScript/JavaScript | ✅ ESLint + Prettier | ✅         | Complete |
| JSON                  | ✅ Prettier          | ✅         | Complete |
| Markdown              | ✅ Prettier          | ✅         | Complete |
| YAML                  | ✅ Prettier          | ✅         | Complete |
| Go                    | ❌                   | ✅         | Partial  |
| Solidity              | ❌                   | ✅         | Partial  |
| Shell Scripts         | ❌                   | ✅         | Partial  |
| Terraform             | ❌                   | ✅         | Partial  |

---

## 🎯 **Recommendations**

### **Untuk Go Files:**

```bash
# Add gofmt to lint-staged
"*.go": ["gofmt -w", "go vet"]
```

### **Untuk Solidity Files:**

```bash
# Add solhint to lint-staged
"*.sol": ["solhint --fix"]
```

### **Untuk Shell Scripts:**

```bash
# Add shellcheck to lint-staged
"*.sh": ["shellcheck"]
```

---

**Status: Husky siap digunakan setelah git init! 🚀**
