#!/bin/bash

# DanaVerse Reset Script
# This script provides comprehensive reset functionality for all projects

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

# Function to reset Mobile Project
reset_mobile() {
	print_header "Resetting Mobile Project (React Native + Expo)"
	echo "=================================================="

	cd apps/mobile

	if [ ! -f "package.json" ]; then
		print_error "Mobile app not found. Please check apps/mobile directory."
		return 1
	fi

	print_status "Cleaning watchman cache..."
	if command_exists watchman; then
		watchman watch-del-all 2>/dev/null || true
	else
		print_warning "Watchman not installed. Skipping watchman cleanup."
	fi

	print_status "Cleaning Metro cache..."
	rm -rf $TMPDIR/metro-* 2>/dev/null || true
	rm -rf $TMPDIR/haste-* 2>/dev/null || true

	print_status "Cleaning node_modules..."
	rm -rf node_modules
	rm -rf .expo
	rm -f package-lock.json
	rm -f yarn.lock
	rm -f pnpm-lock.yaml

	print_status "Cleaning iOS build artifacts..."
	if [ -d "ios" ]; then
		cd ios
		rm -rf build
		rm -rf Pods
		rm -rf ~/Library/Developer/Xcode/DerivedData/* 2>/dev/null || true

		if command_exists pod; then
			pod cache clean --all 2>/dev/null || true
		else
			print_warning "CocoaPods not installed. Skipping pod cache cleanup."
		fi
		cd ..
	fi

	print_status "Cleaning Android build artifacts..."
	if [ -d "android" ]; then
		cd android
		if [ -f "gradlew" ]; then
			./gradlew clean 2>/dev/null || true
		fi
		rm -rf build
		rm -rf .gradle
		cd ..
	fi

	print_status "Reinstalling dependencies..."
	pnpm install

	print_status "Running prebuild..."
	echo "Y" | npx expo prebuild --clean --no-install
	pnpm install

	print_success "Mobile project reset complete!"
	cd ../..
}

# Function to reset Web Project
reset_web() {
	print_header "Resetting Web Project (Next.js)"
	echo "===================================="

	cd apps/web

	if [ ! -f "package.json" ]; then
		print_error "Web app not found. Please check apps/web directory."
		return 1
	fi

	print_status "Cleaning node_modules..."
	rm -rf node_modules
	rm -rf .next
	rm -rf out
	rm -f package-lock.json
	rm -f yarn.lock
	rm -f pnpm-lock.yaml

	print_status "Reinstalling dependencies..."
	pnpm install

	print_success "Web project reset complete!"
	cd ../..
}

# Function to reset API Project
reset_api() {
	print_header "Resetting API Project (Go)"
	echo "==============================="

	cd apps/api

	if [ ! -f "main.go" ]; then
		print_error "API app not found. Please check apps/api directory."
		return 1
	fi

	print_status "Cleaning Go build artifacts..."
	go clean -cache 2>/dev/null || true
	go clean -modcache 2>/dev/null || true
	go clean -testcache 2>/dev/null || true
	rm -f *.exe 2>/dev/null || true
	rm -f *.out 2>/dev/null || true

	print_status "Downloading dependencies..."
	go mod download 2>/dev/null || true
	go mod tidy 2>/dev/null || true

	print_success "API project reset complete!"
	cd ../..
}

# Function to reset Contracts Project
reset_contracts() {
	print_header "Resetting Contracts Project (Foundry)"
	echo "==========================================="

	cd contracts

	if [ ! -f "foundry.toml" ]; then
		print_error "Contracts not found. Please check contracts directory."
		return 1
	fi

	print_status "Cleaning Foundry cache..."
	if command_exists forge; then
		forge clean 2>/dev/null || true
	else
		print_warning "Foundry not installed. Skipping forge clean."
	fi

	print_status "Cleaning build artifacts..."
	rm -rf out
	rm -rf cache
	rm -rf lib

	print_status "Reinstalling dependencies..."
	if command_exists forge; then
		forge install 2>/dev/null || true
	fi

	print_success "Contracts project reset complete!"
	cd ..
}

# Function to reset Global Dependencies
reset_global() {
	print_header "Resetting Global Dependencies"
	echo "=================================="

	print_status "Cleaning root node_modules..."
	rm -rf node_modules
	rm -f package-lock.json
	rm -f yarn.lock
	rm -f pnpm-lock.yaml

	print_status "Cleaning pnpm cache..."
	if command_exists pnpm; then
		pnpm store prune 2>/dev/null || true
	fi

	print_status "Cleaning npm cache..."
	if command_exists npm; then
		npm cache clean --force 2>/dev/null || true
	fi

	print_status "Cleaning yarn cache..."
	if command_exists yarn; then
		yarn cache clean 2>/dev/null || true
	fi

	print_status "Reinstalling root dependencies..."
	pnpm install

	print_success "Global dependencies reset complete!"
}

# Function to reset All Projects
reset_all() {
	print_header "Resetting All Projects"
	echo "========================"

	print_warning "This will reset ALL projects. Are you sure? (y/N)"
	read -r confirmation

	if [[ $confirmation =~ ^[Yy]$ ]]; then
		reset_global
		reset_web
		reset_mobile
		reset_api
		reset_contracts

		print_success "All projects reset complete!"
	else
		print_warning "Reset cancelled by user."
	fi
}

# Function to show help
show_help() {
	echo "🔄 DanaVerse Reset Script"
	echo "========================"
	echo ""
	echo "Usage: $0 [command]"
	echo ""
	echo "Commands:"
	echo "  all        - Reset all projects (with confirmation)"
	echo "  global     - Reset global dependencies and root"
	echo "  mobile     - Reset mobile project (React Native + Expo)"
	echo "  web        - Reset web project (Next.js)"
	echo "  api        - Reset API project (Go)"
	echo "  contracts  - Reset contracts project (Foundry)"
	echo "  help       - Show this help message"
	echo ""
	echo "Examples:"
	echo "  $0 mobile          # Reset mobile project only"
	echo "  $0 all             # Reset all projects"
	echo "  $0 global          # Reset global dependencies"
	echo ""
	echo "Mobile Reset includes:"
	echo "  - Watchman cache cleanup"
	echo "  - Metro cache cleanup"
	echo "  - iOS build artifacts (Xcode DerivedData, Pods)"
	echo "  - Android build artifacts (Gradle cache)"
	echo "  - Node modules and lock files"
	echo "  - Expo prebuild regeneration"
	echo ""
}

# Main function
main() {
	# Check if we're in the right directory
	if [ ! -f "pnpm-workspace.yaml" ]; then
		print_error "Please run this script from the project root directory"
		exit 1
	fi

	# Parse command line arguments
	case "${1:-help}" in
	"all")
		reset_all
		;;
	"global")
		reset_global
		;;
	"mobile")
		reset_mobile
		;;
	"web")
		reset_web
		;;
	"api")
		reset_api
		;;
	"contracts")
		reset_contracts
		;;
	"help" | "-h" | "--help")
		show_help
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
