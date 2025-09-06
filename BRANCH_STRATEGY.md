# 🌿 Branch Strategy - DanaVerse

## 📋 **Overview**

DanaVerse menggunakan **Git Flow** branching strategy yang mendukung:

- **Feature development** - Development di branch terpisah
- **Release management** - Staging dan production deployment
- **Hotfix support** - Critical fixes untuk production
- **CI/CD integration** - Automated testing dan deployment

---

## 🌳 **Branch Structure**

### **Main Branches**

#### **`main`** - Production Branch

- **Purpose**: Production-ready code
- **Protection**: ✅ Protected dengan branch protection rules
- **Deployment**: Automatic deployment ke production
- **Merging**: Hanya dari `develop` atau `hotfix/*`

#### **`develop`** - Integration Branch

- **Purpose**: Integration branch untuk development
- **Protection**: ✅ Protected dengan branch protection rules
- **Deployment**: Automatic deployment ke staging
- **Merging**: Hanya dari `feature/*` atau `release/*`

#### **`staging`** - Staging Branch

- **Purpose**: Staging environment untuk testing
- **Protection**: ✅ Protected dengan branch protection rules
- **Deployment**: Manual deployment ke staging
- **Merging**: Hanya dari `develop` atau `feature/*`

### **Supporting Branches**

#### **`feature/*`** - Feature Development

- **Naming**: `feature/feature-name` (e.g., `feature/user-authentication`)
- **Purpose**: Development fitur baru
- **Base**: `develop`
- **Merging**: Ke `develop` via Pull Request
- **Lifecycle**: Dihapus setelah merge

#### **`release/*`** - Release Preparation

- **Naming**: `release/version` (e.g., `release/v1.2.0`)
- **Purpose**: Preparation untuk release
- **Base**: `develop`
- **Merging**: Ke `main` dan `develop`
- **Lifecycle**: Dihapus setelah merge

#### **`hotfix/*`** - Critical Fixes

- **Naming**: `hotfix/issue-description` (e.g., `hotfix/security-patch`)
- **Purpose**: Critical fixes untuk production
- **Base**: `main`
- **Merging**: Ke `main` dan `develop`
- **Lifecycle**: Dihapus setelah merge

---

## 🔄 **Workflow**

### **1. Feature Development**

```bash
# 1. Create feature branch dari develop
git checkout develop
git pull origin develop
git checkout -b feature/user-authentication

# 2. Develop feature
git add .
git commit -m "feat(auth): add user authentication"

# 3. Push dan create Pull Request
git push origin feature/user-authentication
# Create PR: feature/user-authentication → develop
```

### **2. Release Process**

```bash
# 1. Create release branch dari develop
git checkout develop
git pull origin develop
git checkout -b release/v1.2.0

# 2. Prepare release (version bump, changelog)
git add .
git commit -m "chore(release): prepare v1.2.0"

# 3. Merge ke main dan develop
git checkout main
git merge release/v1.2.0
git tag v1.2.0
git push origin main --tags

git checkout develop
git merge release/v1.2.0
git push origin develop

# 4. Delete release branch
git branch -d release/v1.2.0
git push origin --delete release/v1.2.0
```

### **3. Hotfix Process**

```bash
# 1. Create hotfix branch dari main
git checkout main
git pull origin main
git checkout -b hotfix/security-patch

# 2. Fix critical issue
git add .
git commit -m "fix(security): patch critical vulnerability"

# 3. Merge ke main dan develop
git checkout main
git merge hotfix/security-patch
git tag v1.2.1
git push origin main --tags

git checkout develop
git merge hotfix/security-patch
git push origin develop

# 4. Delete hotfix branch
git branch -d hotfix/security-patch
git push origin --delete hotfix/security-patch
```

---

## 🛡️ **Branch Protection Rules**

### **Main Branch Protection**

- ✅ **Require pull request reviews** (2 reviewers)
- ✅ **Require status checks to pass** (CI pipeline)
- ✅ **Require branches to be up to date**
- ✅ **Require linear history**
- ✅ **Restrict pushes to matching branches**
- ✅ **Allow force pushes** (disabled)
- ✅ **Allow deletions** (disabled)

### **Develop Branch Protection**

- ✅ **Require pull request reviews** (1 reviewer)
- ✅ **Require status checks to pass** (CI pipeline)
- ✅ **Require branches to be up to date**
- ✅ **Require linear history**
- ✅ **Restrict pushes to matching branches**

### **Staging Branch Protection**

- ✅ **Require pull request reviews** (1 reviewer)
- ✅ **Require status checks to pass** (CI pipeline)
- ✅ **Require branches to be up to date**
- ✅ **Restrict pushes to matching branches**

---

## 🚀 **CI/CD Integration**

### **Branch-based Deployment**

#### **`main` Branch**

- **Trigger**: Push ke `main`
- **Actions**:
  - Run full CI pipeline
  - Deploy ke production
  - Create release tags
  - Update documentation

#### **`develop` Branch**

- **Trigger**: Push ke `develop`
- **Actions**:
  - Run full CI pipeline
  - Deploy ke staging
  - Run integration tests
  - Update staging documentation

#### **`staging` Branch**

- **Trigger**: Push ke `staging`
- **Actions**:
  - Run full CI pipeline
  - Deploy ke staging
  - Run smoke tests
  - Update staging documentation

#### **`feature/*` Branches**

- **Trigger**: Push ke `feature/*`
- **Actions**:
  - Run selective CI pipeline
  - Run unit tests
  - Run linting
  - No deployment

#### **`release/*` Branches**

- **Trigger**: Push ke `release/*`
- **Actions**:
  - Run full CI pipeline
  - Deploy ke staging
  - Run release tests
  - Prepare release artifacts

#### **`hotfix/*` Branches**

- **Trigger**: Push ke `hotfix/*`
- **Actions**:
  - Run full CI pipeline
  - Deploy ke staging
  - Run critical tests
  - Prepare hotfix artifacts

---

## 📝 **Naming Conventions**

### **Branch Naming**

- **Feature**: `feature/feature-name` (e.g., `feature/user-authentication`)
- **Release**: `release/version` (e.g., `release/v1.2.0`)
- **Hotfix**: `hotfix/issue-description` (e.g., `hotfix/security-patch`)
- **Bugfix**: `bugfix/issue-description` (e.g., `bugfix/login-error`)

### **Commit Messages**

- **Format**: `type(scope): description`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- **Scopes**: `web`, `mobile`, `api`, `contracts`, `infra`, `packages`

### **Tag Naming**

- **Format**: `v{major}.{minor}.{patch}`
- **Examples**: `v1.0.0`, `v1.2.0`, `v1.2.1`
- **Pre-release**: `v1.2.0-rc.1`, `v1.2.0-beta.1`

---

## 🔧 **Setup Instructions**

### **1. Initialize Branch Protection**

```bash
# Run branch protection workflow
gh workflow run branch-protection.yml -f branch=main
gh workflow run branch-protection.yml -f branch=develop
gh workflow run branch-protection.yml -f branch=staging
```

### **2. Setup Environments**

```bash
# Run environment setup workflow
gh workflow run environment-setup.yml -f environment=staging
gh workflow run environment-setup.yml -f environment=production
```

### **3. Configure Branch Protection Rules**

1. Go to **Repository Settings** > **Branches**
2. Add rule for each branch:
   - **Branch name pattern**: `main`, `develop`, `staging`
   - **Protect matching branches**: ✅
   - **Require pull request reviews**: ✅
   - **Require status checks to pass**: ✅
   - **Require branches to be up to date**: ✅
   - **Require linear history**: ✅
   - **Restrict pushes to matching branches**: ✅

---

## 📊 **Branch Status**

### **Current Branches**

- ✅ **`main`** - Production ready
- ✅ **`develop`** - Integration ready
- ✅ **`staging`** - Staging ready

### **Branch Health**

- ✅ **All branches protected**
- ✅ **CI/CD pipeline active**
- ✅ **Automated testing enabled**
- ✅ **Code quality checks enabled**

---

## 🎯 **Best Practices**

### **1. Branch Management**

- ✅ **Keep branches short-lived** (max 1 week)
- ✅ **Delete merged branches** immediately
- ✅ **Use descriptive branch names**
- ✅ **Follow naming conventions**

### **2. Merge Strategy**

- ✅ **Use Pull Requests** for all merges
- ✅ **Require code reviews** for all changes
- ✅ **Run CI pipeline** before merging
- ✅ **Squash commits** when merging

### **3. Release Management**

- ✅ **Use semantic versioning**
- ✅ **Create release notes**
- ✅ **Tag releases** properly
- ✅ **Test in staging** before production

### **4. Hotfix Management**

- ✅ **Use hotfix branches** for critical fixes
- ✅ **Merge to both** main and develop
- ✅ **Test thoroughly** before deployment
- ✅ **Document hotfix** process

---

## 🚨 **Emergency Procedures**

### **Critical Production Issue**

1. **Create hotfix branch** dari `main`
2. **Fix critical issue** immediately
3. **Test fix** in staging
4. **Merge to main** and deploy
5. **Merge to develop** to keep in sync
6. **Delete hotfix branch**

### **Branch Protection Bypass**

1. **Contact repository admin**
2. **Provide justification** for bypass
3. **Document bypass** in issue
4. **Restore protection** after fix

---

**Status: Branch strategy siap digunakan! 🌿**
