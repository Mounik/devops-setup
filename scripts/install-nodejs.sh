#!/bin/bash

# Node.js Installation Script
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

# Install Node.js
install_nodejs() {
    print_info "Installing Node.js..."

    if command_exists node && command_exists npm; then
        print_success "Node.js is already installed: $(node --version), npm $(npm --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y curl

    # Add NodeSource repository for latest LTS
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs

    if command_exists node && command_exists npm; then
        print_success "Node.js installed successfully: $(node --version), npm $(npm --version)"
    else
        print_error "Node.js installation failed"
        return 1
    fi
}

# Main execution
install_nodejs