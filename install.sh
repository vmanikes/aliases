#!/bin/bash

# Simple Git Aliases Installer
# Sets up 'ship' and 'commit' aliases for streamlined Git workflow

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHIP_SCRIPT="$SCRIPT_DIR/git/ship.sh"
COMMIT_SCRIPT="$SCRIPT_DIR/git/commit.sh"

# Function to detect shell and get config file
get_config_file() {
    # Check what shell the user is actually using
    local user_shell=$(ps -p $$ -o comm= 2>/dev/null || echo "")
    local shell_from_env="$SHELL"
    
    # Prioritize checking the user's default shell from $SHELL
    if [[ "$shell_from_env" == *"zsh"* ]]; then
        echo "$HOME/.zshrc"
    elif [[ "$shell_from_env" == *"bash"* ]]; then
        if [[ -f "$HOME/.bashrc" ]]; then
            echo "$HOME/.bashrc"
        else
            echo "$HOME/.bash_profile"
        fi
    # Fallback to checking environment variables (when script runs in same shell)
    elif [[ -n "$ZSH_VERSION" ]]; then
        echo "$HOME/.zshrc"
    elif [[ -n "$BASH_VERSION" ]]; then
        if [[ -f "$HOME/.bashrc" ]]; then
            echo "$HOME/.bashrc"
        else
            echo "$HOME/.bash_profile"
        fi
    else
        # Final fallback - check if .zshrc exists (common on macOS)
        if [[ -f "$HOME/.zshrc" ]]; then
            echo "$HOME/.zshrc"
        else
            echo "$HOME/.bashrc"
        fi
    fi
}

# Main installation function
main() {
    print_info "Installing Git aliases..."
    
    # Check if scripts exist
    if [[ ! -f "$SHIP_SCRIPT" ]]; then
        print_error "ship.sh not found at: $SHIP_SCRIPT"
        exit 1
    fi
    
    if [[ ! -f "$COMMIT_SCRIPT" ]]; then
        print_error "commit.sh not found at: $COMMIT_SCRIPT"
        exit 1
    fi
    
    # Make scripts executable
    chmod +x "$SHIP_SCRIPT"
    chmod +x "$COMMIT_SCRIPT"
    
    # Get config file
    local config_file=$(get_config_file)
    
    # Show shell detection info
    print_info "Detected shell: $SHELL"
    print_info "Config file: $config_file"
    
    # Define aliases
    local ship_alias="alias ship='$SHIP_SCRIPT'"
    local commit_alias="alias commit='$COMMIT_SCRIPT'"
    
    # Check if aliases already exist and remove them
    if [[ -f "$config_file" ]]; then
        if grep -q "alias ship=" "$config_file" || grep -q "alias commit=" "$config_file"; then
            print_warning "Git aliases already exist, updating..."
            
            # Create backup
            cp "$config_file" "$config_file.backup.$(date +%Y%m%d_%H%M%S)"
            
            # Remove old aliases
            grep -v "alias ship=" "$config_file" | grep -v "alias commit=" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"
        fi
    fi
    
    # Add new aliases
    echo "" >> "$config_file"
    echo "# Git Workflow Aliases" >> "$config_file"
    echo "$ship_alias" >> "$config_file"
    echo "$commit_alias" >> "$config_file"
    
    print_success "Successfully installed Git aliases!"
    echo ""
    print_info "Aliases added to: $config_file"
    echo ""
    print_info "Usage:"
    echo "  ship feat ENG-1234 \"add user authentication\"  # First commit to new branch"
    echo "  commit \"fix validation logic\"                  # Subsequent commits"
    
    # Instructions for manual reload
    echo ""
    print_info "To activate the aliases, either:"
    echo "  1. Restart your terminal"
    echo "  2. Run: source $config_file"
    echo "  3. Open a new terminal tab/window"
    echo ""
    print_success "Installation complete! Ready to use once you reload your shell."
}

main "$@"