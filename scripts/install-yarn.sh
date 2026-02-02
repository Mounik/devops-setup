#!/bin/bash

# Yarn Installation Script
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

# Install Yarn
install_yarn() {
    print_info "Installing Yarn..."

    if command_exists yarn; then
        print_success "Yarn is already installed: $(yarn --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get install -y curl gnupg

    # Add Yarn repository
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt-get update -qq
    sudo apt-get install -y yarn

    if command_exists yarn; then
        print_success "Yarn installed successfully: $(yarn --version)"
    else
        print_error "Yarn installation failed"
        return 1
    fi
}

# Main execution
install_yarn