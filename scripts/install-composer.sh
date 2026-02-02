#!/bin/bash

# Composer Installation Script
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

# Install Composer
install_composer() {
    print_info "Installing Composer..."

    if command_exists composer; then
        print_success "Composer is already installed: $(composer --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get install -y curl php-cli

    # Download and install Composer
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer

    if command_exists composer; then
        print_success "Composer installed successfully: $(composer --version)"
    else
        print_error "Composer installation failed"
        return 1
    fi
}

# Main execution
install_composer