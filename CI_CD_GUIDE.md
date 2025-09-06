# 🚀 CI/CD Pipeline Guide - DanaVerse

## 📋 **Overview**

DanaVerse menggunakan GitHub Actions untuk CI/CD pipeline yang mendukung:
- **Selective builds** - Hanya build project yang berubah
- **Matrix strategy** - Build parallel untuk semua project
- **Automated deployment** - Deploy berdasarkan tags
- **Environment management** - Staging dan Production

---

## 🔄 **CI/CD Workflow**

### **1. Continuous Integration (CI)**

**File**: `.github/workflows/ci.yml`

**Trigger**:
- Push ke `main` atau `develop`
- Pull Request ke `main` atau `develop`

**Features**:
- ✅ **Change Detection** - Hanya build project yang berubah
- ✅ **Matrix Strategy** - Build parallel untuk semua project
- ✅ **Caching** - Cache dependencies untuk performa
- ✅ **Security Scanning** - Trivy vulnerability scanner
- ✅ **Coverage Reports** - Code coverage untuk semua project

**Projects**:
- **API** (Go) - Lint, test, coverage
- **Web** (Next.js) - Lint, type-check, build, test
- **Mobile** (React Native) - Lint, type-check, test
- **Contracts** (Solidity) - Lint, compile, test, gas report
- **Infrastructure** (Terraform) - Format check, validate, plan
- **Packages** (TypeScript) - Lint, type-check, build

### **2. Continuous Deployment (CD)**

**File**: `.github/workflows/deploy.yml`

**Trigger**:
- Tags dengan format: `{project}-v{version}`
- Manual workflow dispatch

**Supported Tags**:
- `web-v1.2.0` - Deploy web application
- `api-v0.5.1` - Deploy API
- `mobile-v0.9.0` - Deploy mobile app
- `contracts-v0.3.2` - Deploy smart contracts

**Environments**:
- **Staging** - Manual deployment
- **Production** - Tag-based deployment

---

## 🏗️ **Project Structure**

```
.github/workflows/
├── ci.yml          # Continuous Integration
└── deploy.yml      # Continuous Deployment

apps/
├── web/            # Next.js application
├── mobile/         # React Native application
├── api/            # Go API server
└── contracts/      # Solidity smart contracts

infra/              # Terraform infrastructure
packages/           # Shared packages
```

---

## 🔧 **Setup Instructions**

### **1. GitHub Secrets**

Tambahkan secrets berikut di GitHub repository:

#### **General Secrets**
```bash
# API Configuration
API_URL=https://api.danaverse.com
VERCEL_TOKEN=your-vercel-token
VERCEL_ORG_ID=your-vercel-org-id
VERCEL_PROJECT_ID=your-vercel-project-id

# Mobile Configuration
EXPO_TOKEN=your-expo-token

# Blockchain Configuration
TESTNET_RPC_URL=https://sepolia.infura.io/v3/your-project-id
MAINNET_RPC_URL=https://mainnet.infura.io/v3/your-project-id
DEPLOYER_PRIVATE_KEY=your-deployer-private-key
CHAIN_ID=1
CONTRACT_ADDRESS=0x...
```

#### **Environment-specific Secrets**
```bash
# Staging
STAGING_API_URL=https://staging-api.danaverse.com
STAGING_DATABASE_URL=postgresql://...

# Production
PRODUCTION_API_URL=https://api.danaverse.com
PRODUCTION_DATABASE_URL=postgresql://...
```

### **2. Environment Files**

Setiap aplikasi memiliki file environment example:

```bash
# Web
apps/web/env.example

# Mobile
apps/mobile/env.example

# API
apps/api/env.example
```

**Setup**:
```bash
# Copy environment files
cp apps/web/env.example apps/web/.env.local
cp apps/mobile/env.example apps/mobile/.env
cp apps/api/env.example apps/api/.env

# Fill in the values
```

---

## 🚀 **Release Management**

### **Release Script**

**File**: `scripts/release.sh`

**Commands**:
```bash
# Show current versions
pnpm release:versions

# Create new release
pnpm release:web minor
pnpm release:api patch
pnpm release:mobile major
pnpm release:contracts minor

# Create release candidate
pnpm rc:web patch 1
pnpm rc:api minor 2
```

### **Release Process**

#### **1. Create Release**
```bash
# Bump version and create tag
pnpm release:web minor

# This will:
# 1. Bump version in package.json
# 2. Commit version bump
# 3. Create tag (web-v1.2.0)
# 4. Push to remote
# 5. Trigger deployment
```

#### **2. Release Candidate**
```bash
# Create RC for testing
pnpm rc:web patch 1

# This will:
# 1. Create RC version (1.2.0-rc.1)
# 2. Create tag (web-v1.2.0-rc.1)
# 3. Deploy to staging
```

#### **3. Production Release**
```bash
# After RC testing, create final release
pnpm release:web patch

# This will:
# 1. Create final version (1.2.0)
# 2. Create tag (web-v1.2.0)
# 3. Deploy to production
```

---

## 📊 **CI/CD Matrix Strategy**

### **Change Detection**

Pipeline menggunakan `dorny/paths-filter` untuk mendeteksi perubahan:

```yaml
filters: |
  api:
    - 'apps/api/**'
    - 'packages/**'
    - 'go.mod'
    - 'go.sum'
  web:
    - 'apps/web/**'
    - 'packages/**'
  mobile:
    - 'apps/mobile/**'
    - 'packages/**'
  contracts:
    - 'contracts/**'
  infra:
    - 'infra/**'
  packages:
    - 'packages/**'
```

### **Selective Builds**

- ✅ **API changes** → Build API only
- ✅ **Web changes** → Build Web only
- ✅ **Package changes** → Build all dependent projects
- ✅ **No changes** → Skip builds

---

## 🔒 **Security & Quality**

### **Security Scanning**
- **Trivy** - Vulnerability scanner
- **SARIF** - Security results upload
- **Dependency scanning** - npm audit, go mod audit

### **Quality Gates**
- **Linting** - ESLint, golangci-lint, solhint
- **Testing** - Unit tests, integration tests
- **Coverage** - Minimum 80% coverage
- **Type checking** - TypeScript strict mode

### **Approval Process**
- **Staging** - Automatic deployment
- **Production** - Manual approval required
- **Security** - All security scans must pass

---

## 📈 **Monitoring & Observability**

### **Build Status**
- **GitHub Actions** - Build status and logs
- **Summary** - Job summary with results
- **Notifications** - Slack/email notifications

### **Deployment Status**
- **Environment** - Staging/Production status
- **Health Checks** - Application health monitoring
- **Rollback** - Automatic rollback on failure

---

## 🛠️ **Troubleshooting**

### **Common Issues**

#### **1. Build Failures**
```bash
# Check build logs
gh run list
gh run view <run-id>

# Local testing
pnpm --filter web build
pnpm --filter mobile build
cd apps/api && go build
```

#### **2. Deployment Failures**
```bash
# Check deployment logs
gh run list --workflow=deploy.yml
gh run view <run-id>

# Manual deployment
gh workflow run deploy.yml -f environment=staging -f project=web
```

#### **3. Environment Issues**
```bash
# Check environment variables
echo $NEXT_PUBLIC_API_URL
echo $DATABASE_URL

# Validate environment files
pnpm --filter web env:validate
```

### **Debug Commands**

```bash
# Test CI locally
act -j api
act -j web
act -j mobile

# Check changes detection
git diff --name-only HEAD~1
```

---

## 📚 **Best Practices**

### **1. Branching Strategy**
- **main** - Production-ready code
- **develop** - Integration branch
- **feature/*** - Feature branches
- **hotfix/*** - Critical fixes

### **2. Commit Messages**
- Use conventional commits
- Include scope (web, api, mobile, contracts)
- Reference issues/PRs

### **3. Release Strategy**
- Use semantic versioning
- Create release candidates for testing
- Document breaking changes
- Tag releases properly

### **4. Environment Management**
- Never commit secrets
- Use environment-specific configs
- Validate environment variables
- Use secrets management

---

## 🎯 **Next Steps**

### **Immediate Actions**
1. ✅ **Setup GitHub Secrets**
2. ✅ **Configure Environment Files**
3. ✅ **Test CI Pipeline**
4. ✅ **Create First Release**

### **Future Enhancements**
- [ ] **Automated testing** - E2E tests
- [ ] **Performance monitoring** - Lighthouse CI
- [ ] **Security scanning** - SAST/DAST
- [ ] **Multi-environment** - Dev/Staging/Prod
- [ ] **Blue-green deployment** - Zero downtime
- [ ] **Canary releases** - Gradual rollout

---

**Status: CI/CD Pipeline siap digunakan! 🚀**
