#!/bin/bash

# DanaVerse Setup Script
# This script sets up the development environment for the DanaVerse monorepo

set -e

echo "🚀 Setting up DanaVerse development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# Check if required tools are installed
check_prerequisites() {
	print_status "Checking prerequisites..."

	# Check Node.js
	if ! command -v node &>/dev/null; then
		print_error "Node.js is not installed. Please install Node.js >= 18.0.0"
		exit 1
	fi

	NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
	if [ "$NODE_VERSION" -lt 18 ]; then
		print_error "Node.js version must be >= 18.0.0. Current version: $(node --version)"
		exit 1
	fi

	# Check PNPM
	if ! command -v pnpm &>/dev/null; then
		print_warning "PNPM is not installed. Installing PNPM..."
		npm install -g pnpm@9
	fi

	# Check Go (optional for API development)
	if ! command -v go &>/dev/null; then
		print_warning "Go is not installed. API development will not be available."
		print_warning "Install Go >= 1.22 to enable API development."
	fi

	# Check Foundry (optional for smart contracts)
	if ! command -v forge &>/dev/null; then
		print_warning "Foundry is not installed. Smart contract development will not be available."
		print_warning "Install Foundry to enable smart contract development:"
		print_warning "curl -L https://foundry.paradigm.xyz | bash && foundryup"
	fi

	print_success "Prerequisites check completed"
}

# Install dependencies
install_dependencies() {
	print_status "Installing dependencies..."
	pnpm install --frozen-lockfile
	print_success "Dependencies installed"
}

# Set up environment files
setup_environment() {
	print_status "Setting up environment files..."

	# API environment
	if [ ! -f "apps/api/.env" ]; then
		cp apps/api/env.example apps/api/.env
		print_success "Created apps/api/.env from example"
	else
		print_warning "apps/api/.env already exists, skipping..."
	fi

	# Web environment
	if [ ! -f "apps/web/.env.local" ]; then
		cp apps/web/env.example apps/web/.env.local
		print_success "Created apps/web/.env.local from example"
	else
		print_warning "apps/web/.env.local already exists, skipping..."
	fi

	# Mobile environment
	if [ ! -f "apps/mobile/.env" ]; then
		cp apps/mobile/env.example apps/mobile/.env
		print_success "Created apps/mobile/.env from example"
	else
		print_warning "apps/mobile/.env already exists, skipping..."
	fi

	print_warning "Please edit the environment files with your actual values:"
	print_warning "- apps/api/.env"
	print_warning "- apps/web/.env.local"
	print_warning "- apps/mobile/.env"
}

# Set up Git hooks
setup_git_hooks() {
	print_status "Setting up Git hooks..."

	if [ -d ".git" ]; then
		# Install husky
		pnpm exec husky install

		print_success "Git hooks configured"
	else
		print_warning "Not a Git repository. Initialize Git to enable hooks:"
		print_warning "git init"
		print_warning "git add ."
		print_warning "git commit -m 'feat: initial commit'"
	fi
}

# Run initial build and tests
run_initial_checks() {
	print_status "Running initial checks..."

	# Lint check
	print_status "Running linting..."
	pnpm lint || print_warning "Linting failed - this is expected for initial setup"

	# Type check
	print_status "Running type checking..."
	pnpm type-check || print_warning "Type checking failed - this is expected for initial setup"

	print_success "Initial checks completed"
}

# Display next steps
show_next_steps() {
	echo ""
	echo "🎉 DanaVerse setup completed!"
	echo ""
	echo "Next steps:"
	echo "1. Edit environment files with your actual values:"
	echo "   - apps/api/.env"
	echo "   - apps/web/.env.local"
	echo "   - apps/mobile/.env"
	echo ""
	echo "2. Start development servers:"
	echo "   pnpm dev                    # Start all services"
	echo "   pnpm --filter @danaverse/web dev    # Start web only"
	echo "   pnpm --filter @danaverse/mobile start # Start mobile only"
	echo "   cd apps/api && go run main.go        # Start API only"
	echo ""
	echo "3. Run tests and linting:"
	echo "   pnpm test                   # Run all tests"
	echo "   pnpm lint                   # Run linting"
	echo "   pnpm type-check             # Run type checking"
	echo ""
	echo "4. Build for production:"
	echo "   pnpm build                  # Build all packages"
	echo ""
	echo "5. Smart contracts (if Foundry is installed):"
	echo "   cd contracts"
	echo "   forge build                 # Build contracts"
	echo "   forge test                  # Run contract tests"
	echo ""
	echo "📚 Documentation: README.md"
	echo "🔧 Configuration: packages/config/"
	echo "🚀 CI/CD: .github/workflows/"
	echo ""
	print_success "Happy coding! 🚀"
}

# Main execution
main() {
	echo "🏗️  DanaVerse Monorepo Setup"
	echo "================================"
	echo ""

	check_prerequisites
	install_dependencies
	setup_environment
	setup_git_hooks
	run_initial_checks
	show_next_steps
}

# Run main function
main "$@"
