#!/bin/bash

# Simple Git Ship - First commit to new branch with ticket
# Usage: ship {conventional commit type} {ticket} {message}
# Example: ship feat ENG-1234 "add user authentication"

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

# Check if we have the right number of arguments
if [[ $# -ne 3 ]]; then
    echo "Usage: ship {conventional commit type} {ticket} {message}"
    echo "Example: ship feat ENG-1234 \"add user authentication\""
    echo ""
    echo "Conventional commit types: feat, fix, docs, style, refactor, test, chore, perf, ci, build"
    exit 1
fi

# Parse arguments
COMMIT_TYPE="$1"
TICKET="$2"
MESSAGE="$3"

# Create branch name: {type}/{ticket}
BRANCH_NAME="${COMMIT_TYPE}/${TICKET}"

print_info "Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

print_info "Adding all changes..."
git add .

print_info "Committing with message: $MESSAGE"
git commit -m "$MESSAGE"

print_info "Pushing to origin..."
git push -u origin "$BRANCH_NAME"

print_success "Successfully shipped! Branch: $BRANCH_NAME"