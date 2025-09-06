#!/bin/bash

# DanaVerse Linters Installation Script
# This script installs code quality tools for all languages in the monorepo

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

# Function to check if command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to install Go tools
install_go_tools() {
	print_header "Installing Go Tools"
	echo "===================="

	if ! command_exists go; then
		print_warning "Go not found. Please install Go first."
		return 1
	fi

	print_status "Installing goimports..."
	go install golang.org/x/tools/cmd/goimports@latest

	print_status "Installing golangci-lint..."
	if command_exists brew; then
		brew install golangci-lint
	else
		curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.54.2
	fi

	print_status "Installing gosec..."
	go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest

	print_success "Go tools installed successfully"
}

# Function to install Solidity tools
install_solidity_tools() {
	print_header "Installing Solidity Tools"
	echo "=========================="

	print_status "Installing solhint..."
	npm install -g solhint

	print_status "Installing slither..."
	if command_exists pip3; then
		pip3 install slither-analyzer
	else
		print_warning "pip3 not found. Please install slither manually."
	fi

	print_status "Installing mythril..."
	if command_exists pip3; then
		pip3 install mythril
	else
		print_warning "pip3 not found. Please install mythril manually."
	fi

	print_success "Solidity tools installed successfully"
}

# Function to install Shell tools
install_shell_tools() {
	print_header "Installing Shell Tools"
	echo "======================="

	print_status "Installing shfmt..."
	if command_exists brew; then
		brew install shfmt
	else
		print_warning "Homebrew not found. Please install shfmt manually."
	fi

	print_status "Installing shellcheck..."
	if command_exists brew; then
		brew install shellcheck
	else
		print_warning "Homebrew not found. Please install shellcheck manually."
	fi

	print_status "Installing bashate..."
	if command_exists pip3; then
		pip3 install bashate
	else
		print_warning "pip3 not found. Please install bashate manually."
	fi

	print_success "Shell tools installed successfully"
}

# Function to install Terraform tools
install_terraform_tools() {
	print_header "Installing Terraform Tools"
	echo "============================"

	if ! command_exists terraform; then
		print_warning "Terraform not found. Please install Terraform first."
		return 1
	fi

	print_status "Installing tflint..."
	if command_exists brew; then
		brew install tflint
	else
		print_warning "Homebrew not found. Please install tflint manually."
	fi

	print_status "Installing tfsec..."
	if command_exists brew; then
		brew install tfsec
	else
		print_warning "Homebrew not found. Please install tfsec manually."
	fi

	print_status "Installing checkov..."
	if command_exists pip3; then
		pip3 install checkov
	else
		print_warning "pip3 not found. Please install checkov manually."
	fi

	print_success "Terraform tools installed successfully"
}

# Function to install all tools
install_all_tools() {
	print_header "Installing All Code Quality Tools"
	echo "===================================="

	install_go_tools
	install_solidity_tools
	install_shell_tools
	install_terraform_tools

	print_success "All tools installed successfully!"
}

# Function to check installed tools
check_tools() {
	print_header "Checking Installed Tools"
	echo "========================="

	echo ""
	print_status "Go Tools:"
	command_exists gofmt && echo "✅ gofmt" || echo "❌ gofmt"
	command_exists goimports && echo "✅ goimports" || echo "❌ goimports"
	command_exists golangci-lint && echo "✅ golangci-lint" || echo "❌ golangci-lint"
	command_exists gosec && echo "✅ gosec" || echo "❌ gosec"

	echo ""
	print_status "Solidity Tools:"
	command_exists solhint && echo "✅ solhint" || echo "❌ solhint"
	command_exists slither && echo "✅ slither" || echo "❌ slither"
	command_exists mythril && echo "✅ mythril" || echo "❌ mythril"

	echo ""
	print_status "Shell Tools:"
	command_exists shfmt && echo "✅ shfmt" || echo "❌ shfmt"
	command_exists shellcheck && echo "✅ shellcheck" || echo "❌ shellcheck"
	command_exists bashate && echo "✅ bashate" || echo "❌ bashate"

	echo ""
	print_status "Terraform Tools:"
	command_exists terraform && echo "✅ terraform" || echo "❌ terraform"
	command_exists tflint && echo "✅ tflint" || echo "❌ tflint"
	command_exists tfsec && echo "✅ tfsec" || echo "❌ tfsec"
	command_exists checkov && echo "✅ checkov" || echo "❌ checkov"
}

# Function to show usage examples
show_examples() {
	print_header "Usage Examples"
	echo "=============="

	echo ""
	print_status "Go:"
	echo "gofmt -w .                    # Format all Go files"
	echo "goimports -w .                # Format + organize imports"
	echo "golangci-lint run             # Run comprehensive linting"
	echo "gosec ./...                   # Security analysis"

	echo ""
	print_status "Solidity:"
	echo "prettier --write \"**/*.sol\"   # Format Solidity files"
	echo "solhint \"contracts/**/*.sol\"  # Lint Solidity files"
	echo "slither .                     # Static analysis"
	echo "forge test                    # Run tests"

	echo ""
	print_status "Shell:"
	echo "shfmt -w .                    # Format shell scripts"
	echo "shellcheck .                  # Lint shell scripts"
	echo "bashate .                     # Style checking"

	echo ""
	print_status "Terraform:"
	echo "terraform fmt -recursive      # Format Terraform files"
	echo "tflint .                      # Lint Terraform files"
	echo "tfsec .                       # Security analysis"
	echo "checkov .                     # Security & compliance"
}

# Main function
main() {
	echo "🛠️  DanaVerse Linters Installation"
	echo "=================================="
	echo ""

	case "${1:-help}" in
	"go")
		install_go_tools
		;;
	"solidity")
		install_solidity_tools
		;;
	"shell")
		install_shell_tools
		;;
	"terraform")
		install_terraform_tools
		;;
	"all")
		install_all_tools
		;;
	"check")
		check_tools
		;;
	"examples")
		show_examples
		;;
	"help" | "-h" | "--help")
		echo "Usage: $0 [command]"
		echo ""
		echo "Commands:"
		echo "  go        - Install Go tools (gofmt, goimports, golangci-lint, gosec)"
		echo "  solidity  - Install Solidity tools (solhint, slither, mythril)"
		echo "  shell     - Install Shell tools (shfmt, shellcheck, bashate)"
		echo "  terraform - Install Terraform tools (tflint, tfsec, checkov)"
		echo "  all       - Install all tools"
		echo "  check     - Check installed tools"
		echo "  examples  - Show usage examples"
		echo "  help      - Show this help message"
		echo ""
		echo "Examples:"
		echo "  $0 all        # Install all tools"
		echo "  $0 go         # Install only Go tools"
		echo "  $0 check      # Check what's installed"
		echo "  $0 examples   # Show usage examples"
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
