#!/bin/bash

# Rust Installation Script
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

# Install Rust
install_rust() {
    print_info "Installing Rust..."

    if command_exists rustc && command_exists cargo; then
        print_success "Rust is already installed: $(rustc --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y curl build-essential

    # Install Rust using rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Source cargo environment for current session
    source "$HOME/.cargo/env"

    # Add to shell profile for persistence
    if [ -f "$HOME/.bashrc" ]; then
        echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
    elif [ -f "$HOME/.zshrc" ]; then
        echo 'source "$HOME/.cargo/env"' >> ~/.zshrc
    fi

    if command_exists rustc && command_exists cargo; then
        print_success "Rust installed successfully: $(rustc --version)"
    else
        print_error "Rust installation failed"
        return 1
    fi
}

# Main execution
install_rust