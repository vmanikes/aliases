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

# Check if we have a message
if [[ $# -ne 1 ]]; then
    echo "Usage: commit {message}"
    echo "Example: commit \"fix validation logic\""
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
