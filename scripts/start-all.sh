#!/bin/bash

# DanaVerse Full Stack Development Script
# This script starts all applications in the monorepo

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

# Function to check if port is in use
port_in_use() {
	lsof -i :$1 >/dev/null 2>&1
}

# Function to start Web Application
start_web() {
	print_status "Starting Web Application (Next.js)..."

	if port_in_use 3000; then
		print_warning "Port 3000 is already in use. Web app may already be running."
		return 0
	fi

	cd apps/web

	if [ ! -f "package.json" ]; then
		print_error "Web app not found. Please check apps/web directory."
		return 1
	fi

	# Open new terminal window for web app
	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD' && echo '🌐 DanaVerse Web App - Next.js' && echo '================================' && echo 'Starting development server...' && pnpm dev\"
        set custom title of newTab to \"DanaVerse Web\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Starting in background instead..."
		pnpm dev >../../logs/web.log 2>&1 &
		WEB_PID=$!
		echo $WEB_PID >../../logs/web.pid
	}

	# Wait a moment for server to start
	sleep 5

	if port_in_use 3000; then
		print_success "Web Application started on http://localhost:3000"
	else
		print_warning "Web Application may still be starting..."
	fi

	cd ../..
}

# Function to start Mobile Application
start_mobile() {
	print_status "Starting Mobile Application (Native Build)..."

	cd apps/mobile

	if [ ! -f "package.json" ]; then
		print_error "Mobile app not found. Please check apps/mobile directory."
		return 1
	fi

	# Check if native projects exist
	if [ ! -d "android" ] || [ ! -d "ios" ]; then
		print_warning "Native projects not found. Running prebuild first..."
		echo "Y" | npx expo prebuild --no-install --clean
		pnpm install
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
		print_status "Opening Android development terminal..."
		osascript -e "
            tell application \"Terminal\"
                activate
                set newTab to do script \"cd '$PWD' && echo '📱 DanaVerse Mobile - Android' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting Android build...' && npx expo run:android\"
                set custom title of newTab to \"DanaVerse Android\"
            end tell
            " 2>/dev/null || {
			print_warning "Could not open Terminal app. Starting in background instead..."
			npx expo run:android >../../logs/mobile-android.log 2>&1 &
			MOBILE_PID=$!
			echo $MOBILE_PID >../../logs/mobile.pid
		}
		print_success "Android development terminal opened"
		;;
	2)
		print_status "Opening iOS development terminal..."
		osascript -e "
            tell application \"Terminal\"
                activate
                set newTab to do script \"cd '$PWD' && echo '📱 DanaVerse Mobile - iOS' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting iOS build...' && npx expo run:ios\"
                set custom title of newTab to \"DanaVerse iOS\"
            end tell
            " 2>/dev/null || {
			print_warning "Could not open Terminal app. Starting in background instead..."
			npx expo run:ios >../../logs/mobile-ios.log 2>&1 &
			MOBILE_PID=$!
			echo $MOBILE_PID >../../logs/mobile.pid
		}
		print_success "iOS development terminal opened"
		;;
	3)
		print_status "Opening both Android and iOS terminals..."
		print_warning "This will open two terminal windows"
		osascript -e "
            tell application \"Terminal\"
                activate
                set newTab to do script \"cd '$PWD' && echo '📱 DanaVerse Mobile - Android' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting Android build...' && npx expo run:android\"
                set custom title of newTab to \"DanaVerse Android\"
            end tell
            " 2>/dev/null || {
			print_warning "Could not open Terminal app. Starting Android in background instead..."
			npx expo run:android >../../logs/mobile-android.log 2>&1 &
			ANDROID_PID=$!
			echo $ANDROID_PID >../../logs/mobile.pid
		}
		sleep 2
		osascript -e "
            tell application \"Terminal\"
                activate
                set newTab to do script \"cd '$PWD' && echo '📱 DanaVerse Mobile - iOS' && echo '================================' && echo 'Package: com.danaverse' && echo 'Starting iOS build...' && npx expo run:ios\"
                set custom title of newTab to \"DanaVerse iOS\"
            end tell
            " 2>/dev/null || {
			print_warning "Could not open Terminal app. Starting iOS in background instead..."
			npx expo run:ios >../../logs/mobile-ios.log 2>&1 &
			IOS_PID=$!
			echo $IOS_PID >>../../logs/mobile.pid
		}
		print_success "Both Android and iOS terminals opened"
		;;
	4)
		print_warning "Skipping mobile app startup"
		cd ../..
		return 0
		;;
	*)
		print_error "Invalid selection. Skipping mobile app startup."
		cd ../..
		return 1
		;;
	esac

	cd ../..
}

# Function to start API Application
start_api() {
	print_status "Starting API Application (Go)..."

	if port_in_use 8080; then
		print_warning "Port 8080 is already in use. API may already be running."
		return 0
	fi

	cd apps/api

	if [ ! -f "main.go" ]; then
		print_error "API app not found. Please check apps/api directory."
		return 1
	fi

	if ! command_exists go; then
		print_warning "Go is not installed. Skipping API startup."
		print_warning "Install Go with: brew install go"
		return 1
	fi

	# Open new terminal window for API
	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD' && echo '🚀 DanaVerse API - Go' && echo '========================' && echo 'Starting API server...' && go run main.go\"
        set custom title of newTab to \"DanaVerse API\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Starting in background instead..."
		go run main.go >../../logs/api.log 2>&1 &
		API_PID=$!
		echo $API_PID >../../logs/api.pid
	}

	# Wait a moment for server to start
	sleep 3

	if port_in_use 8080; then
		print_success "API Application started on http://localhost:8080"
	else
		print_warning "API Application may still be starting..."
	fi

	cd ../..
}

# Function to start Smart Contracts
start_contracts() {
	print_status "Starting Smart Contracts (Foundry)..."

	cd contracts

	if [ ! -f "foundry.toml" ]; then
		print_error "Contracts not found. Please check contracts directory."
		return 1
	fi

	if ! command_exists forge; then
		print_warning "Foundry is not installed. Skipping contracts startup."
		print_warning "Install Foundry with: curl -L https://foundry.paradigm.xyz | bash && foundryup"
		return 1
	fi

	# Open new terminal window for contracts
	osascript -e "
    tell application \"Terminal\"
        activate
        set newTab to do script \"cd '$PWD' && echo '🔗 DanaVerse Contracts - Foundry' && echo '=================================' && echo 'Building contracts...' && forge build\"
        set custom title of newTab to \"DanaVerse Contracts\"
    end tell
    " 2>/dev/null || {
		print_warning "Could not open Terminal app. Starting in background instead..."
		forge build >../logs/contracts.log 2>&1 &
		CONTRACTS_PID=$!
		echo $CONTRACTS_PID >../logs/contracts.pid
	}

	print_success "Smart Contracts terminal opened"

	cd ..
}

# Function to create logs directory
create_logs_dir() {
	if [ ! -d "logs" ]; then
		mkdir -p logs
		print_status "Created logs directory"
	fi
}

# Function to show status
show_status() {
	echo ""
	print_header "DanaVerse Development Status"
	echo "================================"

	if port_in_use 3000; then
		print_success "Web App: http://localhost:3000"
	else
		print_warning "Web App: Not running"
	fi

	# Check for native mobile apps
	if pgrep -f "expo.*run:android" >/dev/null 2>&1; then
		print_success "Mobile App (Android): Native build running"
	elif pgrep -f "expo.*run:ios" >/dev/null 2>&1; then
		print_success "Mobile App (iOS): Native build running"
	elif port_in_use 8081; then
		print_success "Mobile App: Metro bundler running on http://localhost:8081"
	else
		print_warning "Mobile App: Not running"
	fi

	if port_in_use 8080; then
		print_success "API: http://localhost:8080"
	else
		print_warning "API: Not running"
	fi

	echo ""
	print_header "Quick Access"
	echo "=============="
	echo "Web App:    http://localhost:3000"
	echo "Mobile App: http://localhost:8081"
	echo "API Health: http://localhost:8080/health"
	echo ""
	print_header "Development Terminals"
	echo "========================"
	echo "Terminal Titles:"
	echo "• DanaVerse Web      - Next.js development"
	echo "• DanaVerse Android  - Android native build"
	echo "• DanaVerse iOS      - iOS native build"
	echo "• DanaVerse API      - Go API server"
	echo "• DanaVerse Contracts - Foundry smart contracts"
	echo ""
	print_header "Mobile Development (Native Build)"
	echo "======================================"
	echo "Package Name: com.danaverse"
	echo "Android: Native APK installed on emulator"
	echo "iOS: Native app installed on simulator"
	echo "Metro Bundler: Hot reload enabled"
	echo "Development: Native development build (not Expo Go)"
	echo ""
}

# Function to stop all applications
stop_all() {
	print_status "Stopping all applications and closing terminals..."

	# Force close all DanaVerse terminals
	print_status "Closing DanaVerse terminals..."
	osascript -e "
    tell application \"Terminal\"
        set terminalWindows to every window
        repeat with aWindow in terminalWindows
            set windowTitle to custom title of aWindow
            if windowTitle contains \"DanaVerse\" then
                close aWindow
            end if
        end repeat
    end tell
    " 2>/dev/null || true

	# Stop web app
	if [ -f "logs/web.pid" ]; then
		WEB_PID=$(cat logs/web.pid)
		kill $WEB_PID 2>/dev/null || true
		rm -f logs/web.pid
		print_success "Web app stopped"
	fi

	# Stop mobile app (native builds)
	if [ -f "logs/mobile.pid" ]; then
		MOBILE_PIDS=$(cat logs/mobile.pid)
		for pid in $MOBILE_PIDS; do
			kill $pid 2>/dev/null || true
		done
		rm -f logs/mobile.pid
		print_success "Mobile app stopped"
	fi

	# Stop API
	if [ -f "logs/api.pid" ]; then
		API_PID=$(cat logs/api.pid)
		kill $API_PID 2>/dev/null || true
		rm -f logs/api.pid
		print_success "API stopped"
	fi

	# Stop contracts
	if [ -f "logs/contracts.pid" ]; then
		CONTRACTS_PID=$(cat logs/contracts.pid)
		kill $CONTRACTS_PID 2>/dev/null || true
		rm -f logs/contracts.pid
		print_success "Contracts stopped"
	fi

	# Kill any remaining processes
	pkill -f "expo.*start" 2>/dev/null || true
	pkill -f "expo.*run:android" 2>/dev/null || true
	pkill -f "expo.*run:ios" 2>/dev/null || true
	pkill -f "next.*dev" 2>/dev/null || true
	pkill -f "go.*run" 2>/dev/null || true
	pkill -f "forge.*build" 2>/dev/null || true

	print_success "All applications stopped and terminals closed"
}

# Function to show logs
show_logs() {
	local app=$1

	case $app in
	"web")
		if [ -f "logs/web.log" ]; then
			tail -f logs/web.log
		else
			print_error "Web logs not found"
		fi
		;;
	"mobile")
		if [ -f "logs/mobile-android.log" ]; then
			print_status "Showing Android logs:"
			tail -f logs/mobile-android.log
		elif [ -f "logs/mobile-ios.log" ]; then
			print_status "Showing iOS logs:"
			tail -f logs/mobile-ios.log
		elif [ -f "logs/mobile.log" ]; then
			print_status "Showing mobile logs:"
			tail -f logs/mobile.log
		else
			print_error "Mobile logs not found"
		fi
		;;
	"mobile-android")
		if [ -f "logs/mobile-android.log" ]; then
			tail -f logs/mobile-android.log
		else
			print_error "Android logs not found"
		fi
		;;
	"mobile-ios")
		if [ -f "logs/mobile-ios.log" ]; then
			tail -f logs/mobile-ios.log
		else
			print_error "iOS logs not found"
		fi
		;;
	"api")
		if [ -f "logs/api.log" ]; then
			tail -f logs/api.log
		else
			print_error "API logs not found"
		fi
		;;
	"contracts")
		if [ -f "logs/contracts.log" ]; then
			tail -f logs/contracts.log
		else
			print_error "Contracts logs not found"
		fi
		;;
	*)
		print_error "Unknown app: $app"
		echo "Available apps: web, mobile, api, contracts"
		;;
	esac
}

# Main function
main() {
	echo "🚀 DanaVerse Full Stack Development Starter"
	echo "=========================================="
	echo ""

	# Check if we're in the right directory
	if [ ! -f "pnpm-workspace.yaml" ]; then
		print_error "Please run this script from the project root directory"
		exit 1
	fi

	# Create logs directory
	create_logs_dir

	# Parse command line arguments
	case "${1:-start}" in
	"start")
		print_status "Starting all applications..."
		start_web
		start_mobile
		start_api
		start_contracts
		show_status
		;;
	"stop")
		stop_all
		;;
	"restart")
		stop_all
		sleep 2
		main start
		;;
	"status")
		show_status
		;;
	"logs")
		show_logs "$2"
		;;
	"web")
		start_web
		show_status
		;;
	"mobile")
		start_mobile
		show_status
		;;
	"api")
		start_api
		show_status
		;;
	"contracts")
		start_contracts
		show_status
		;;
	"help" | "-h" | "--help")
		echo "Usage: $0 [command] [app]"
		echo ""
		echo "Commands:"
		echo "  start      - Start all applications (default)"
		echo "  stop       - Stop all applications"
		echo "  restart    - Restart all applications"
		echo "  status     - Show current status"
		echo "  logs [app] - Show logs for specific app"
		echo "  web        - Start only web app"
		echo "  mobile     - Start only mobile app"
		echo "  api        - Start only API"
		echo "  contracts  - Start only contracts"
		echo "  help       - Show this help message"
		echo ""
		echo "Apps for logs: web, mobile, mobile-android, mobile-ios, api, contracts"
		echo ""
		echo "Examples:"
		echo "  $0 start           # Start all apps"
		echo "  $0 stop            # Stop all apps"
		echo "  $0 logs web        # Show web app logs"
		echo "  $0 mobile          # Start only mobile app"
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
