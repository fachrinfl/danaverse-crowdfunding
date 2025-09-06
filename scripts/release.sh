#!/bin/bash

# DanaVerse Release Management Script
# This script helps manage releases across different projects in the monorepo

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

# Function to check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        exit 1
    fi
}

# Function to check if working directory is clean
check_clean_working_dir() {
    if ! git diff-index --quiet HEAD --; then
        print_error "Working directory is not clean. Please commit or stash your changes."
        exit 1
    fi
}

# Function to get current version for a project
get_current_version() {
    local project=$1
    local version_file=""
    
    case $project in
        "web")
            version_file="apps/web/package.json"
            ;;
        "mobile")
            version_file="apps/mobile/package.json"
            ;;
        "api")
            version_file="apps/api/go.mod"
            ;;
        "contracts")
            version_file="contracts/package.json"
            ;;
        *)
            print_error "Unknown project: $project"
            exit 1
            ;;
    esac
    
    if [ -f "$version_file" ]; then
        if [[ $version_file == *.json ]]; then
            grep '"version"' "$version_file" | sed 's/.*"version": *"\([^"]*\)".*/\1/'
        else
            grep '^module' "$version_file" | sed 's/.*v\([0-9.]*\).*/\1/'
        fi
    else
        echo "0.0.0"
    fi
}

# Function to bump version
bump_version() {
    local project=$1
    local bump_type=$2
    local current_version=$(get_current_version "$project")
    local new_version=""
    
    # Parse current version
    IFS='.' read -ra VERSION_PARTS <<< "$current_version"
    local major=${VERSION_PARTS[0]:-0}
    local minor=${VERSION_PARTS[1]:-0}
    local patch=${VERSION_PARTS[2]:-0}
    
    case $bump_type in
        "major")
            new_version="$((major + 1)).0.0"
            ;;
        "minor")
            new_version="$major.$((minor + 1)).0"
            ;;
        "patch")
            new_version="$major.$minor.$((patch + 1))"
            ;;
        *)
            print_error "Invalid bump type: $bump_type. Use major, minor, or patch"
            exit 1
            ;;
    esac
    
    echo "$new_version"
}

# Function to update version in files
update_version() {
    local project=$1
    local new_version=$2
    local version_file=""
    
    case $project in
        "web")
            version_file="apps/web/package.json"
            sed -i.bak "s/\"version\": \".*\"/\"version\": \"$new_version\"/" "$version_file"
            rm "$version_file.bak"
            ;;
        "mobile")
            version_file="apps/mobile/package.json"
            sed -i.bak "s/\"version\": \".*\"/\"version\": \"$new_version\"/" "$version_file"
            rm "$version_file.bak"
            ;;
        "api")
            version_file="apps/api/go.mod"
            sed -i.bak "s/^module.*v[0-9.]*/module github.com\/danaverse\/api v$new_version/" "$version_file"
            rm "$version_file.bak"
            ;;
        "contracts")
            version_file="contracts/package.json"
            sed -i.bak "s/\"version\": \".*\"/\"version\": \"$new_version\"/" "$version_file"
            rm "$version_file.bak"
            ;;
    esac
}

# Function to create release
create_release() {
    local project=$1
    local version=$2
    local release_notes=$3
    
    print_header "Creating release for $project v$version"
    
    # Update version in files
    update_version "$project" "$version"
    
    # Commit version bump
    git add .
    git commit -m "chore($project): bump version to $version"
    
    # Create tag
    local tag_name="${project}-v${version}"
    git tag -a "$tag_name" -m "$release_notes"
    
    print_success "Created tag: $tag_name"
    
    # Push changes and tag
    git push origin main
    git push origin "$tag_name"
    
    print_success "Pushed release $tag_name to remote"
}

# Function to create release candidate
create_release_candidate() {
    local project=$1
    local version=$2
    local rc_number=$3
    local release_notes=$4
    
    local rc_version="${version}-rc.${rc_number}"
    local tag_name="${project}-v${rc_version}"
    
    print_header "Creating release candidate for $project v$rc_version"
    
    # Update version in files
    update_version "$project" "$rc_version"
    
    # Commit version bump
    git add .
    git commit -m "chore($project): bump version to $rc_version"
    
    # Create tag
    git tag -a "$tag_name" -m "$release_notes"
    
    print_success "Created RC tag: $tag_name"
    
    # Push changes and tag
    git push origin main
    git push origin "$tag_name"
    
    print_success "Pushed RC $tag_name to remote"
}

# Function to show current versions
show_versions() {
    print_header "Current Versions"
    echo ""
    
    for project in web mobile api contracts; do
        local version=$(get_current_version "$project")
        echo "  $project: v$version"
    done
    echo ""
}

# Function to show help
show_help() {
    echo "DanaVerse Release Management Script"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  versions                    Show current versions of all projects"
    echo "  release <project> <type>    Create a new release"
    echo "  rc <project> <type> <num>   Create a release candidate"
    echo "  help                        Show this help message"
    echo ""
    echo "Projects:"
    echo "  web, mobile, api, contracts"
    echo ""
    echo "Version Types:"
    echo "  major, minor, patch"
    echo ""
    echo "Examples:"
    echo "  $0 versions"
    echo "  $0 release web minor"
    echo "  $0 rc api patch 1"
    echo ""
}

# Main function
main() {
    check_git_repo
    
    case "${1:-help}" in
        "versions")
            show_versions
            ;;
        "release")
            if [ $# -lt 3 ]; then
                print_error "Usage: $0 release <project> <type>"
                exit 1
            fi
            
            local project=$2
            local bump_type=$3
            
            check_clean_working_dir
            
            local current_version=$(get_current_version "$project")
            local new_version=$(bump_version "$project" "$bump_type")
            
            print_status "Bumping $project from v$current_version to v$new_version"
            
            read -p "Enter release notes: " release_notes
            
            create_release "$project" "$new_version" "$release_notes"
            ;;
        "rc")
            if [ $# -lt 4 ]; then
                print_error "Usage: $0 rc <project> <type> <rc_number>"
                exit 1
            fi
            
            local project=$2
            local bump_type=$3
            local rc_number=$4
            
            check_clean_working_dir
            
            local current_version=$(get_current_version "$project")
            local new_version=$(bump_version "$project" "$bump_type")
            
            print_status "Creating RC for $project v$new_version-rc.$rc_number"
            
            read -p "Enter release notes: " release_notes
            
            create_release_candidate "$project" "$new_version" "$rc_number" "$release_notes"
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
