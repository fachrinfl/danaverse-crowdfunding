#!/bin/bash

# DanaVerse Mobile Development Script
# This script helps you start the mobile development environment

set -e

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

# Function to check if command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to check if emulator is running
check_ios_simulator() {
	if xcrun simctl list devices | grep -q "Booted"; then
		return 0
	else
		return 1
	fi
}

check_android_emulator() {
	if adb devices | grep -q "emulator.*device"; then
		return 0
	else
		return 1
	fi
}

# Function to start iOS simulator
start_ios_simulator() {
	print_status "Starting iOS Simulator..."

	if ! command_exists xcrun; then
		print_error "Xcode command line tools not found. Please install Xcode."
		exit 1
	fi

	# Boot iPhone 16 Pro simulator
	xcrun simctl boot "iPhone 16 Pro" 2>/dev/null || true
	open -a Simulator

	print_success "iOS Simulator started"
}

# Function to start Android emulator
start_android_emulator() {
	print_status "Starting Android Emulator..."

	if ! command_exists adb; then
		print_error "Android SDK not found. Please install Android Studio and set ANDROID_HOME."
		exit 1
	fi

	# Start Pixel 9 emulator
	$ANDROID_HOME/emulator/emulator -avd Pixel_9 &

	# Wait for emulator to start
	print_status "Waiting for Android emulator to start..."
	sleep 10

	# Check if emulator is running
	if check_android_emulator; then
		print_success "Android Emulator started"
	else
		print_warning "Android Emulator may still be starting..."
	fi
}

# Function to start Expo development server
start_expo() {
	print_status "Starting Expo development server..."

	cd apps/mobile

	if ! command_exists pnpm; then
		print_error "PNPM not found. Please install PNPM."
		exit 1
	fi

	# Kill any existing Expo processes
	pkill -f "expo.*start" 2>/dev/null || true

	# Start Expo
	pnpm start
}

# Main function
main() {
	echo "🚀 DanaVerse Mobile Development Starter"
	echo "======================================"
	echo ""

	# Check if we're in the right directory
	if [ ! -f "pnpm-workspace.yaml" ]; then
		print_error "Please run this script from the project root directory"
		exit 1
	fi

	# Parse command line arguments
	case "${1:-all}" in
	"ios")
		print_status "Starting iOS development environment..."
		start_ios_simulator
		start_expo
		;;
	"android")
		print_status "Starting Android development environment..."
		start_android_emulator
		start_expo
		;;
	"web")
		print_status "Starting web development environment..."
		start_expo
		;;
	"all" | "")
		print_status "Starting full development environment..."

		# Check current emulator status
		if ! check_ios_simulator; then
			start_ios_simulator
		else
			print_success "iOS Simulator already running"
		fi

		if ! check_android_emulator; then
			start_android_emulator
		else
			print_success "Android Emulator already running"
		fi

		start_expo
		;;
	"check")
		print_status "Checking development environment..."

		if check_ios_simulator; then
			print_success "iOS Simulator: Running"
		else
			print_warning "iOS Simulator: Not running"
		fi

		if check_android_emulator; then
			print_success "Android Emulator: Running"
		else
			print_warning "Android Emulator: Not running"
		fi

		if pgrep -f "expo.*start" >/dev/null; then
			print_success "Expo Server: Running"
		else
			print_warning "Expo Server: Not running"
		fi
		;;
	"help" | "-h" | "--help")
		echo "Usage: $0 [platform]"
		echo ""
		echo "Platforms:"
		echo "  ios      - Start iOS simulator and Expo"
		echo "  android  - Start Android emulator and Expo"
		echo "  web      - Start Expo for web development"
		echo "  all      - Start all platforms (default)"
		echo "  check    - Check current status"
		echo "  help     - Show this help message"
		echo ""
		echo "Examples:"
		echo "  $0 ios      # Start iOS development"
		echo "  $0 android  # Start Android development"
		echo "  $0 check    # Check status"
		;;
	*)
		print_error "Unknown platform: $1"
		echo "Use '$0 help' for usage information"
		exit 1
		;;
	esac
}

# Run main function with all arguments
main "$@"
