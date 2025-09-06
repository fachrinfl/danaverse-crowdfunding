#!/bin/bash

# DanaVerse Development Terminals Script
# This script opens separate terminals for each project for better development experience

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

# Function to open terminal for Web App
open_web_terminal() {
	print_status "Opening Web App terminal..."

	if [ ! -f "apps/web/package.json" ]; then
		print_error "Web app not found. Please check apps/web directory."
		return 1
	fi

	# Open new terminal window for web app
	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD/apps/web && echo '🌐 DanaVerse Web App - Next.js' && echo '================================' && echo 'Starting development server...' && pnpm dev\"
        set custom title of newTab to \"DanaVerse Web\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Trying alternative method..."
		# Alternative: open in new iTerm2 window if available
		if command_exists iterm2; then
			iterm2 --new-window --working-directory "$PWD/apps/web" --command "echo '🌐 DanaVerse Web App - Next.js' && echo '================================' && pnpm dev"
		else
			print_error "Could not open terminal. Please open manually: cd apps/web && pnpm dev"
		fi
	}

	print_success "Web App terminal opened"
}

# Function to open terminal for Mobile App
open_mobile_terminal() {
	print_status "Opening Mobile App terminal..."

	if [ ! -f "apps/mobile/package.json" ]; then
		print_error "Mobile app not found. Please check apps/mobile directory."
		return 1
	fi

	# Ask user which platform to run
	echo ""
	print_header "Mobile Platform Selection"
	echo "=============================="
	echo "1) Android (emulator)"
	echo "2) iOS (simulator)"
	echo "3) Both platforms"
	echo "4) Skip mobile"
	echo ""
	read -p "Select platform (1-4): " platform_choice

	case $platform_choice in
	1)
		open_mobile_android_terminal
		;;
	2)
		open_mobile_ios_terminal
		;;
	3)
		open_mobile_android_terminal
		sleep 2
		open_mobile_ios_terminal
		;;
	4)
		print_warning "Skipping mobile app startup"
		return 0
		;;
	*)
		print_error "Invalid selection. Skipping mobile app startup."
		return 1
		;;
	esac
}

# Function to open Android terminal
open_mobile_android_terminal() {
	print_status "Opening Android development terminal..."

	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD/apps/mobile && echo '📱 DanaVerse Mobile - Android' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting Android build...' && npx expo run:android\"
        set custom title of newTab to \"DanaVerse Android\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Trying alternative method..."
		if command_exists iterm2; then
			iterm2 --new-window --working-directory "$PWD/apps/mobile" --command "echo '📱 DanaVerse Mobile - Android' && echo '================================' && npx expo run:android"
		else
			print_error "Could not open terminal. Please open manually: cd apps/mobile && npx expo run:android"
		fi
	}

	print_success "Android development terminal opened"
}

# Function to open iOS terminal
open_mobile_ios_terminal() {
	print_status "Opening iOS development terminal..."

	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD/apps/mobile && echo '📱 DanaVerse Mobile - iOS' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting iOS build...' && npx expo run:ios\"
        set custom title of newTab to \"DanaVerse iOS\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Trying alternative method..."
		if command_exists iterm2; then
			iterm2 --new-window --working-directory "$PWD/apps/mobile" --command "echo '📱 DanaVerse Mobile - iOS' && echo '================================' && npx expo run:ios"
		else
			print_error "Could not open terminal. Please open manually: cd apps/mobile && npx expo run:ios"
		fi
	}

	print_success "iOS development terminal opened"
}

# Function to open terminal for API
open_api_terminal() {
	print_status "Opening API terminal..."

	if [ ! -f "apps/api/main.go" ]; then
		print_error "API app not found. Please check apps/api directory."
		return 1
	fi

	if ! command_exists go; then
		print_warning "Go is not installed. Skipping API startup."
		print_warning "Install Go with: brew install go"
		return 1
	fi

	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD/apps/api && echo '🚀 DanaVerse API - Go' && echo '========================' && echo 'Starting API server...' && go run main.go\"
        set custom title of newTab to \"DanaVerse API\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Trying alternative method..."
		if command_exists iterm2; then
			iterm2 --new-window --working-directory "$PWD/apps/api" --command "echo '🚀 DanaVerse API - Go' && echo '========================' && go run main.go"
		else
			print_error "Could not open terminal. Please open manually: cd apps/api && go run main.go"
		fi
	}

	print_success "API terminal opened"
}

# Function to open terminal for Contracts
open_contracts_terminal() {
	print_status "Opening Contracts terminal..."

	if [ ! -f "contracts/foundry.toml" ]; then
		print_error "Contracts not found. Please check contracts directory."
		return 1
	fi

	if ! command_exists forge; then
		print_warning "Foundry is not installed. Skipping contracts startup."
		print_warning "Install Foundry with: curl -L https://foundry.paradigm.xyz | bash && foundryup"
		return 1
	fi

	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD/contracts && echo '🔗 DanaVerse Contracts - Foundry' && echo '=================================' && echo 'Building contracts...' && forge build\"
        set custom title of newTab to \"DanaVerse Contracts\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Trying alternative method..."
		if command_exists iterm2; then
			iterm2 --new-window --working-directory "$PWD/contracts" --command "echo '🔗 DanaVerse Contracts - Foundry' && echo '=================================' && forge build"
		else
			print_error "Could not open terminal. Please open manually: cd contracts && forge build"
		fi
	}

	print_success "Contracts terminal opened"
}

# Function to open all terminals
open_all_terminals() {
	print_header "Opening All Development Terminals"
	echo "====================================="

	print_warning "This will open multiple terminal windows. Continue? (y/N)"
	read -r confirmation

	if [[ $confirmation =~ ^[Yy]$ ]]; then
		open_web_terminal
		sleep 1
		open_mobile_terminal
		sleep 1
		open_api_terminal
		sleep 1
		open_contracts_terminal

		print_success "All development terminals opened!"
		echo ""
		print_header "Development URLs"
		echo "=================="
		echo "Web App:    http://localhost:3000"
		echo "API Health: http://localhost:8080/health"
		echo "Metro:      http://localhost:8081"
		echo ""
		print_header "Terminal Titles"
		echo "================"
		echo "• DanaVerse Web      - Next.js development"
		echo "• DanaVerse Android  - Android native build"
		echo "• DanaVerse iOS      - iOS native build"
		echo "• DanaVerse API      - Go API server"
		echo "• DanaVerse Contracts - Foundry smart contracts"
	else
		print_warning "Terminal opening cancelled by user."
	fi
}

# Function to show help
show_help() {
	echo "🖥️  DanaVerse Development Terminals"
	echo "=================================="
	echo ""
	echo "Usage: $0 [command]"
	echo ""
	echo "Commands:"
	echo "  all        - Open all development terminals"
	echo "  web        - Open web app terminal only"
	echo "  mobile     - Open mobile app terminal (with platform selection)"
	echo "  android    - Open Android development terminal"
	echo "  ios        - Open iOS development terminal"
	echo "  api        - Open API terminal only"
	echo "  contracts  - Open contracts terminal only"
	echo "  help       - Show this help message"
	echo ""
	echo "Examples:"
	echo "  $0 all             # Open all terminals"
	echo "  $0 mobile          # Open mobile terminal with platform selection"
	echo "  $0 android         # Open Android terminal only"
	echo "  $0 web             # Open web terminal only"
	echo ""
	echo "Benefits:"
	echo "  • Separate terminals for each project"
	echo "  • Real-time log monitoring"
	echo "  • Easy debugging and development"
	echo "  • Organized development workflow"
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
		open_all_terminals
		;;
	"web")
		open_web_terminal
		;;
	"mobile")
		open_mobile_terminal
		;;
	"android")
		open_mobile_android_terminal
		;;
	"ios")
		open_mobile_ios_terminal
		;;
	"api")
		open_api_terminal
		;;
	"contracts")
		open_contracts_terminal
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
