#!/bin/bash

# Checkov Installation Script
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

# Install Checkov
install_checkov() {
    print_info "Installing Checkov..."
    
    if command_exists checkov; then
        print_success "Checkov is already installed: $(checkov --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y python3 python3-pip python3-venv

    # Install Checkov via pip
    pip3 install --user checkov

    # Add to PATH if not already there
    if ! command_exists checkov; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if command_exists checkov; then
        print_success "Checkov installed successfully: $(checkov --version)"
    else
        print_error "Checkov installation failed"
        return 1
    fi
}

# Main execution
install_checkov