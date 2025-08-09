#!/bin/bash

# Simple Git Commit - Subsequent commits on existing branch
# Usage: commit {message}
# Example: commit "fix validation logic"

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to show help
show_help() {
    echo "Commit - Add, commit and push changes"
    echo ""
    echo "Usage: commit {message}"
    echo ""
    echo "Arguments:"
    echo "  message  Commit message"
    echo ""
    echo "Examples:"
    echo "  commit \"fix validation logic\""
    echo "  commit \"add error handling\""
    echo "  commit \"update documentation\""
    echo ""
    echo "What this does:"
    echo "  1. Adds all changes: git add ."
    echo "  2. Commits with message: git commit -m \"{message}\""
    echo "  3. Pushes to current branch: git push"
    echo ""
    echo "Note: Use this for subsequent commits on an existing branch."
    echo "For the first commit to a new branch, use 'ship' instead."
}

# Check for help flag
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if we have a message
if [[ $# -ne 1 ]]; then
    echo "Error: Expected 1 argument, got $#"
    echo ""
    show_help
    exit 1
fi

MESSAGE="$1"

print_info "Adding all changes..."
git add .

print_info "Committing with message: $MESSAGE"
git commit -m "$MESSAGE"

print_info "Pushing..."
git push

print_success "Successfully committed and pushed!"
