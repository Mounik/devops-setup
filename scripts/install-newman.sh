#!/bin/bash

# Newman Installation Script
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

# Install Newman
install_newman() {
    print_info "Installing Newman..."
    
    if command_exists newman; then
        print_success "Newman is already installed: $(newman --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y nodejs npm

    # Install Newman globally
    npm install -g newman

    if command_exists newman; then
        print_success "Newman installed successfully: $(newman --version)"
    else
        print_error "Newman installation failed"
        return 1
    fi
}

# Main execution
install_newman