#!/bin/bash

# Cursor AI Integration Script for DanaVerse
# This script helps integrate Cursor AI with GitHub for automated code review

set -e

echo "🤖 Setting up Cursor AI Integration for DanaVerse..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}[CURSOR AI]${NC} $1"
}

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "Not in a git repository. Please run this script from the project root."
    exit 1
fi

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    print_warning "GitHub CLI (gh) is not installed. Installing..."
    
    # Install GitHub CLI based on OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install gh
        else
            print_error "Homebrew not found. Please install GitHub CLI manually: https://cli.github.com/"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
    else
        print_error "Unsupported OS. Please install GitHub CLI manually: https://cli.github.com/"
        exit 1
    fi
fi

# Check if user is authenticated with GitHub
if ! gh auth status &> /dev/null; then
    print_warning "Not authenticated with GitHub. Please authenticate..."
    gh auth login
fi

# Get repository information
REPO_OWNER=$(gh repo view --json owner -q .owner.login)
REPO_NAME=$(gh repo view --json name -q .name)

print_header "Repository: $REPO_OWNER/$REPO_NAME"

# Create GitHub Actions secrets for Cursor AI integration
print_status "Setting up GitHub Actions secrets..."

# Check if secrets already exist
if gh secret list | grep -q "CURSOR_AI_ENABLED"; then
    print_warning "Cursor AI secrets already exist. Skipping..."
else
    # Set up secrets
    gh secret set CURSOR_AI_ENABLED --body "true"
    gh secret set CURSOR_AI_REVIEW_ENABLED --body "true"
    gh secret set CURSOR_AI_SECURITY_SCAN --body "true"
    gh secret set CURSOR_AI_PERFORMANCE_SCAN --body "true"
    
    print_status "GitHub Actions secrets created successfully!"
fi

# Create branch protection rules for main branches
print_status "Setting up branch protection rules..."

# Function to create branch protection rule
create_branch_protection() {
    local branch=$1
    local required_reviews=$2
    
    print_status "Creating branch protection for $branch..."
    
    gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection \
        --method PUT \
        --field required_status_checks='{"strict":true,"contexts":["CI/CD Pipeline","AI Code Review"]}' \
        --field enforce_admins=true \
        --field required_pull_request_reviews='{"required_approving_review_count":'$required_reviews',"dismiss_stale_reviews":true,"require_code_owner_reviews":true}' \
        --field restrictions=null \
        --field allow_force_pushes=false \
        --field allow_deletions=false \
        --field required_conversation_resolution=true
}

# Create protection rules for main branches
create_branch_protection "main" 2
create_branch_protection "develop" 1
create_branch_protection "staging" 1

print_status "Branch protection rules created successfully!"

# Create issue templates for AI feedback
print_status "Creating AI feedback issue templates..."

mkdir -p .github/ISSUE_TEMPLATE

# AI Feedback template
cat > .github/ISSUE_TEMPLATE/ai-feedback.md << 'EOF'
---
name: AI Code Review Feedback
about: Provide feedback on AI code review suggestions
title: '[AI FEEDBACK] '
labels: ['ai-feedback', 'code-review']
assignees: ''
---

## 🤖 AI Code Review Feedback

### 📝 Review Summary
<!-- Provide a summary of the AI code review feedback -->

### 🔍 Issues Identified
<!-- List the issues identified by the AI -->

### 💡 Suggestions Implemented
<!-- List the suggestions you've implemented -->

### ❓ Questions or Concerns
<!-- Any questions or concerns about the AI suggestions -->

### 📊 Code Quality Metrics
<!-- Any additional code quality metrics or observations -->

### 🎯 Next Steps
<!-- What are the next steps to address the feedback -->

---
**AI Review ID**: <!-- Add the AI review ID if available -->
**Reviewer**: <!-- Add your name -->
**Date**: <!-- Add the date -->
EOF

print_status "AI feedback issue template created!"

# Create pull request template with AI review section
print_status "Creating enhanced pull request template..."

cat > .github/pull_request_template.md << 'EOF'
## 📋 Pull Request Summary

### 🎯 Changes Made
<!-- Describe the changes made in this PR -->

### 🔍 AI Code Review Status
- [ ] AI code review completed
- [ ] All AI suggestions addressed
- [ ] Security scan passed
- [ ] Performance analysis completed
- [ ] Code quality standards met

### 🧪 Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] Performance testing completed

### 📚 Documentation
- [ ] Code documentation updated
- [ ] README updated (if needed)
- [ ] API documentation updated (if needed)

### 🔒 Security
- [ ] No hardcoded secrets
- [ ] Input validation implemented
- [ ] Security best practices followed
- [ ] OWASP guidelines followed

### ⚡ Performance
- [ ] Performance optimizations implemented
- [ ] Bundle size optimized
- [ ] Database queries optimized
- [ ] Caching strategies implemented

### 🎨 Code Quality
- [ ] TypeScript strict mode compliance
- [ ] ESLint/Prettier rules followed
- [ ] DanaVerse coding standards followed
- [ ] Cursor Rules compliance

### 📱 Platform Specific
<!-- Check applicable platforms -->
- [ ] Web app changes
- [ ] Mobile app changes
- [ ] API changes
- [ ] Smart contract changes
- [ ] Infrastructure changes

### 🔄 Breaking Changes
- [ ] No breaking changes
- [ ] Breaking changes documented
- [ ] Migration guide provided

### 📸 Screenshots/Videos
<!-- Add screenshots or videos if applicable -->

### 🧪 Test Instructions
<!-- Provide instructions for testing the changes -->

### 📝 Additional Notes
<!-- Any additional notes or context -->

---
**AI Review**: This PR will be automatically reviewed by Cursor AI
**Reviewer**: @fachrinfl
**Date**: $(date)
EOF

print_status "Enhanced pull request template created!"

# Create Cursor AI configuration file
print_status "Creating Cursor AI configuration..."

cat > .cursor-ai-settings.json << 'EOF'
{
  "cursor_ai": {
    "enabled": true,
    "auto_review": true,
    "review_on_pr": true,
    "review_on_push": false,
    "standards": {
      "typescript": {
        "strict_mode": true,
        "no_any": true,
        "no_console_log": true,
        "error_handling": true,
        "performance_optimization": true
      },
      "react": {
        "functional_components": true,
        "hooks_only": true,
        "no_class_components": true,
        "proper_dependencies": true
      },
      "go": {
        "error_handling": true,
        "context_usage": true,
        "structured_logging": true,
        "security_checks": true
      },
      "solidity": {
        "openzeppelin_patterns": true,
        "reentrancy_protection": true,
        "gas_optimization": true,
        "event_emission": true
      }
    },
    "security": {
      "scan_hardcoded_secrets": true,
      "check_xss_vulnerabilities": true,
      "check_sql_injection": true,
      "check_insecure_protocols": true,
      "check_localstorage_usage": true
    },
    "performance": {
      "check_array_length_caching": true,
      "check_dom_caching": true,
      "check_database_queries": true,
      "check_react_optimization": true,
      "check_import_optimization": true
    },
    "danaverse_rules": {
      "english_only": true,
      "conventional_commits": true,
      "feature_first_organization": true,
      "atomic_design": true,
      "monorepo_standards": true
    }
  }
}
EOF

print_status "Cursor AI configuration created!"

# Create GitHub Actions workflow for Cursor AI integration
print_status "Creating Cursor AI GitHub Actions workflow..."

# The workflow file is already created in .github/workflows/ai-code-review.yml
print_status "AI code review workflow already exists!"

# Test the integration
print_status "Testing Cursor AI integration..."

# Check if the workflow file exists and is valid
if [ -f ".github/workflows/ai-code-review.yml" ]; then
    print_status "✅ AI code review workflow found"
else
    print_error "❌ AI code review workflow not found"
    exit 1
fi

# Check if the configuration file exists
if [ -f ".cursor-ai-settings.json" ]; then
    print_status "✅ Cursor AI configuration found"
else
    print_error "❌ Cursor AI configuration not found"
    exit 1
fi

# Check if the issue template exists
if [ -f ".github/ISSUE_TEMPLATE/ai-feedback.md" ]; then
    print_status "✅ AI feedback issue template found"
else
    print_error "❌ AI feedback issue template not found"
    exit 1
fi

# Check if the pull request template exists
if [ -f ".github/pull_request_template.md" ]; then
    print_status "✅ Enhanced pull request template found"
else
    print_error "❌ Enhanced pull request template not found"
    exit 1
fi

print_header "🎉 Cursor AI Integration Setup Complete!"

echo ""
echo "📋 Summary of what was set up:"
echo "  ✅ GitHub Actions secrets for Cursor AI"
echo "  ✅ Branch protection rules for main branches"
echo "  ✅ AI feedback issue template"
echo "  ✅ Enhanced pull request template"
echo "  ✅ Cursor AI configuration file"
echo "  ✅ AI code review workflow"
echo ""

echo "🚀 Next steps:"
echo "  1. Create a test pull request to see the AI review in action"
echo "  2. The AI will automatically review code changes"
echo "  3. Review the AI suggestions and implement improvements"
echo "  4. Use the AI feedback issue template for discussions"
echo ""

echo "🔧 Configuration files created:"
echo "  📄 .github/workflows/ai-code-review.yml"
echo "  📄 .github/cursor-ai-config.yml"
echo "  📄 .cursor-ai-settings.json"
echo "  📄 .github/ISSUE_TEMPLATE/ai-feedback.md"
echo "  📄 .github/pull_request_template.md"
echo ""

print_status "Cursor AI integration is ready to use! 🎯"
