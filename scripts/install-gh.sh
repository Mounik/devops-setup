#!/bin/bash

# GitHub CLI Installation Script
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

# Install GitHub CLI
install_gh() {
    print_info "Installing GitHub CLI..."

    if command_exists gh; then
        print_success "GitHub CLI is already installed: $(gh --version)"
        return 0
    fi

    # Add GitHub CLI repository
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt-get update -qq
    sudo apt-get install -y gh

    if command_exists gh; then
        print_success "GitHub CLI installed successfully: $(gh --version)"
    else
        print_error "GitHub CLI installation failed"
        return 1
    fi
}

# Main execution
install_gh