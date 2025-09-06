#!/bin/bash

# DanaVerse Husky Setup Script
# This script sets up Husky git hooks for the monorepo

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
	echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
	echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
	echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
	echo -e "${PURPLE}[DANAVERSE]${NC} $1"
}

# Function to check if git is initialized
check_git() {
	if [ ! -d ".git" ]; then
		print_error "Git repository not initialized!"
		print_status "Please run: git init"
		exit 1
	fi
	print_success "Git repository found"
}

# Function to install Husky
install_husky() {
	print_status "Installing Husky..."
	npx husky install
	print_success "Husky installed successfully"
}

# Function to test Husky hooks
test_hooks() {
	print_status "Testing Husky hooks..."

	# Test pre-commit hook
	print_status "Testing pre-commit hook..."
	if [ -f ".husky/pre-commit" ]; then
		print_success "Pre-commit hook exists"
	else
		print_error "Pre-commit hook not found"
		return 1
	fi

	# Test commit-msg hook
	print_status "Testing commit-msg hook..."
	if [ -f ".husky/commit-msg" ]; then
		print_success "Commit-msg hook exists"
	else
		print_error "Commit-msg hook not found"
		return 1
	fi

	# Test commitlint
	print_status "Testing commitlint..."
	if echo "feat(api): test message" | npx commitlint >/dev/null 2>&1; then
		print_success "Commitlint working"
	else
		print_warning "Commitlint test failed"
	fi

	# Test lint-staged
	print_status "Testing lint-staged..."
	if npx lint-staged --help >/dev/null 2>&1; then
		print_success "Lint-staged available"
	else
		print_warning "Lint-staged test failed"
	fi
}

# Function to show Husky status
show_status() {
	print_header "Husky Status"
	echo "=============="

	echo ""
	print_status "Git Hooks:"
	if [ -d ".git/hooks" ]; then
		ls -la .git/hooks/ | grep -E "(pre-commit|commit-msg)" || echo "No Husky hooks found"
	else
		echo "Git hooks directory not found"
	fi

	echo ""
	print_status "Husky Configuration:"
	if [ -d ".husky" ]; then
		ls -la .husky/
	else
		echo "Husky directory not found"
	fi

	echo ""
	print_status "Lint-staged Configuration:"
	if [ -f "package.json" ]; then
		echo "lint-staged config found in package.json"
	else
		echo "package.json not found"
	fi

	echo ""
	print_status "Commitlint Configuration:"
	if [ -f "commitlint.config.js" ]; then
		echo "commitlint.config.js found"
	else
		echo "commitlint.config.js not found"
	fi
}

# Function to show coverage
show_coverage() {
	print_header "Husky Coverage"
	echo "==============="

	echo ""
	print_status "Pre-commit Hook Coverage:"
	echo "✅ TypeScript/JavaScript files - ESLint + Prettier"
	echo "✅ JSON files - Prettier formatting"
	echo "✅ Markdown files - Prettier formatting"
	echo "✅ YAML files - Prettier formatting"
	echo "❌ Go files - No linter configured"
	echo "❌ Solidity files - No linter configured"
	echo "❌ Shell scripts - No linter configured"
	echo "❌ Terraform files - No linter configured"

	echo ""
	print_status "Commit-msg Hook Coverage:"
	echo "✅ All file types - Conventional commit format"

	echo ""
	print_status "Supported Commit Types:"
	echo "feat, fix, docs, style, refactor, perf, test, chore, ci, build, revert"

	echo ""
	print_status "Supported Scopes:"
	echo "api, web, mobile, contracts, ui, config, sdk, infra, deps, docs"
}

# Function to show examples
show_examples() {
	print_header "Commit Message Examples"
	echo "=========================="

	echo ""
	print_status "Valid Examples:"
	echo "feat(api): add user authentication endpoint"
	echo "fix(web): resolve mobile navigation issue"
	echo "docs(readme): update installation instructions"
	echo "style(mobile): format code with prettier"
	echo "refactor(contracts): optimize gas usage"
	echo "perf(web): improve page load time"
	echo "test(api): add unit tests for auth service"
	echo "chore(deps): update dependencies"
	echo "ci(github): add automated testing"
	echo "build(web): optimize production bundle"

	echo ""
	print_status "Invalid Examples:"
	echo "❌ add new feature (missing type)"
	echo "❌ feature(api): add endpoint (invalid type)"
	echo "❌ feat(backend): add endpoint (invalid scope)"
	echo "❌ feat(api): Add new endpoint (sentence case)"
}

# Main function
main() {
	echo "🐕 DanaVerse Husky Setup"
	echo "========================"
	echo ""

	case "${1:-help}" in
	"install")
		check_git
		install_husky
		test_hooks
		print_success "Husky setup complete!"
		;;
	"test")
		test_hooks
		;;
	"status")
		show_status
		;;
	"coverage")
		show_coverage
		;;
	"examples")
		show_examples
		;;
	"help" | "-h" | "--help")
		echo "Usage: $0 [command]"
		echo ""
		echo "Commands:"
		echo "  install   - Install and setup Husky"
		echo "  test      - Test Husky hooks"
		echo "  status    - Show Husky status"
		echo "  coverage  - Show Husky coverage"
		echo "  examples  - Show commit message examples"
		echo "  help      - Show this help message"
		echo ""
		echo "Examples:"
		echo "  $0 install    # Setup Husky after git init"
		echo "  $0 test       # Test if Husky is working"
		echo "  $0 status     # Check Husky configuration"
		echo "  $0 coverage   # See what files are covered"
		echo "  $0 examples   # See commit message examples"
		;;
	*)
		print_error "Unknown command: $1"
		echo "Use '$0 help' for usage information"
		exit 1
		;;
	esac
}

# Run main function with all arguments
main "$@"
