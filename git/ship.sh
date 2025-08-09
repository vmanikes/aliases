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

# Function to show help
show_help() {
    echo "Ship - Create new branch and first commit"
    echo ""
    echo "Usage: ship {conventional commit type} {ticket} {message}"
    echo ""
    echo "Arguments:"
    echo "  type     Conventional commit type"
    echo "  ticket   Ticket/issue number (e.g., ENG-1234)"
    echo "  message  Commit message"
    echo ""
    echo "Conventional commit types:"
    echo "  feat     - A new feature"
    echo "  fix      - A bug fix"
    echo "  docs     - Documentation changes"
    echo "  style    - Code style changes"
    echo "  refactor - Code refactoring"
    echo "  test     - Adding or updating tests"
    echo "  chore    - Maintenance tasks"
    echo "  perf     - Performance improvements"
    echo "  ci       - CI/CD changes"
    echo "  build    - Build system changes"
    echo ""
    echo "Examples:"
    echo "  ship feat ENG-1234 \"add user authentication\""
    echo "  ship fix ENG-5678 \"resolve login bug\""
    echo "  ship docs ENG-9999 \"update API documentation\""
    echo ""
    echo "What this does:"
    echo "  1. Creates branch: {type}/{ticket}"
    echo "  2. Adds all changes: git add ."
    echo "  3. Commits with conventional format: {type}({ticket}): {message}"
    echo "  4. Pushes to origin: git push -u origin {branch}"
    echo "  5. Opens GitHub Pull Request (if gh/hub CLI available)"
}

# Check for help flag
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if we have the right number of arguments
if [[ $# -ne 3 ]]; then
    echo "Error: Expected 3 arguments, got $#"
    echo ""
    show_help
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

# Create conventional commit message with ticket as scope
COMMIT_MESSAGE="${COMMIT_TYPE}(${TICKET}): ${MESSAGE}"

print_info "Committing with message: $COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

print_info "Pushing to origin..."
git push -u origin "$BRANCH_NAME"

# Try to open GitHub PR
print_info "Opening GitHub Pull Request..."
if command -v gh &> /dev/null; then
    # GitHub CLI is available
    gh pr create --title "$COMMIT_MESSAGE" --body "Automated PR created by ship command" --draft
    print_success "Draft PR created! You can edit it on GitHub."
elif command -v hub &> /dev/null; then
    # Hub is available
    hub pull-request -m "$COMMIT_MESSAGE" -d
    print_success "Draft PR created! You can edit it on GitHub."
else
    # No GitHub tools available, show manual instructions
    print_info "GitHub CLI (gh) or Hub not found."
    print_info "To create a PR manually, visit:"
    echo "  https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/compare/$BRANCH_NAME"
fi

print_success "Successfully shipped! Branch: $BRANCH_NAME"