#!/bin/bash

# NVM Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install NVM
install_nvm() {
    print_info "Installing NVM..."

    if [ -d "$HOME/.nvm" ]; then
        print_success "NVM is already installed"
        return 0
    fi

    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

    # Load NVM for current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    if [ -d "$HOME/.nvm" ]; then
        print_success "NVM installed successfully"
        print_info "Run 'source ~/.bashrc' or restart terminal to use NVM"
    else
        print_error "NVM installation failed"
        return 1
    fi
}

# Main execution
install_nvm