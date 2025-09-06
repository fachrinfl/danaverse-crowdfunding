#!/bin/bash

# Fix Branch Protection Script for DanaVerse
# This script fixes the branch protection rules that failed during initial setup

set -e

echo "🔧 Fixing Branch Protection Rules for DanaVerse..."

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
    echo -e "${BLUE}[BRANCH PROTECTION]${NC} $1"
}

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "Not in a git repository. Please run this script from the project root."
    exit 1
fi

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    print_error "GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

# Check if user is authenticated with GitHub
if ! gh auth status &> /dev/null; then
    print_error "Not authenticated with GitHub. Please run 'gh auth login' first."
    exit 1
fi

# Get repository information
REPO_OWNER=$(gh repo view --json owner -q .owner.login)
REPO_NAME=$(gh repo view --json name -q .name)

print_header "Repository: $REPO_OWNER/$REPO_NAME"

# Function to create branch protection rule with correct format
create_branch_protection() {
    local branch=$1
    local required_reviews=$2
    
    print_status "Creating branch protection for $branch..."
    
    # Check if branch exists
    if ! gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch &> /dev/null; then
        print_warning "Branch $branch does not exist. Skipping..."
        return 0
    fi
    
    # Create branch protection with correct JSON format
    if gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection \
        --method PUT \
        --input - << EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["CI/CD Pipeline", "AI Code Review"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": $required_reviews,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
EOF
    then
        print_status "✅ Branch protection created for $branch"
    else
        print_error "❌ Failed to create branch protection for $branch"
        return 1
    fi
}

# Function to check existing branch protection
check_branch_protection() {
    local branch=$1
    
    print_status "Checking existing branch protection for $branch..."
    
    if gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection &> /dev/null; then
        print_warning "Branch protection already exists for $branch"
        return 0
    else
        print_status "No branch protection found for $branch"
        return 1
    fi
}

# Function to update branch protection
update_branch_protection() {
    local branch=$1
    local required_reviews=$2
    
    print_status "Updating branch protection for $branch..."
    
    # Update branch protection with correct JSON format
    if gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection \
        --method PUT \
        --input - << EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["CI/CD Pipeline", "AI Code Review"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": $required_reviews,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
EOF
    then
        print_status "✅ Branch protection updated for $branch"
    else
        print_error "❌ Failed to update branch protection for $branch"
        return 1
    fi
}

# Main execution
print_header "🔧 Fixing Branch Protection Rules..."

# Process each branch
branches=("main" "develop" "staging")
required_reviews=(2 1 1)

for i in "${!branches[@]}"; do
    branch="${branches[$i]}"
    reviews="${required_reviews[$i]}"
    
    print_status "Processing branch: $branch (requires $reviews reviews)"
    
    if check_branch_protection "$branch"; then
        # Branch protection exists, update it
        update_branch_protection "$branch" "$reviews"
    else
        # No branch protection, create it
        create_branch_protection "$branch" "$reviews"
    fi
    
    echo ""
done

# Verify branch protection rules
print_header "🔍 Verifying Branch Protection Rules..."

for branch in "${branches[@]}"; do
    print_status "Verifying branch protection for $branch..."
    
    if gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection &> /dev/null; then
        print_status "✅ Branch protection verified for $branch"
        
        # Show protection details
        echo "Protection details for $branch:"
        gh api repos/$REPO_OWNER/$REPO_NAME/branches/$branch/protection | jq -r '
            "  Required Status Checks: " + (.required_status_checks.contexts | join(", ")),
            "  Required Reviews: " + (.required_pull_request_reviews.required_approving_review_count | tostring),
            "  Enforce Admins: " + (.enforce_admins | tostring),
            "  Allow Force Push: " + (.allow_force_pushes | tostring),
            "  Allow Deletions: " + (.allow_deletions | tostring)
        '
        echo ""
    else
        print_error "❌ Branch protection not found for $branch"
    fi
done

print_header "🎉 Branch Protection Fix Complete!"

echo ""
echo "📋 Summary:"
echo "  ✅ Branch protection rules have been fixed"
echo "  ✅ All branches now have proper protection"
echo "  ✅ Required status checks: CI/CD Pipeline, AI Code Review"
echo "  ✅ Required reviews: main (2), develop (1), staging (1)"
echo ""

echo "🔧 Protection Rules Applied:"
echo "  🛡️  Required Status Checks: CI/CD Pipeline, AI Code Review"
echo "  👥 Required Reviews: main (2), develop (1), staging (1)"
echo "  🔒 Enforce Admins: true"
echo "  🚫 Allow Force Push: false"
echo "  🚫 Allow Deletions: false"
echo "  💬 Required Conversation Resolution: true"
echo ""

print_status "Branch protection is now properly configured! 🎯"
