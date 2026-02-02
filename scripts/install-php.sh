#!/bin/bash

# PHP Installation Script
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

# Install PHP
install_php() {
    print_info "Installing PHP..."

    if command_exists php; then
        print_success "PHP is already installed: $(php --version | head -n1)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update -qq

    # Install PHP and common extensions
    sudo apt-get install -y php8.2 php8.2-cli php8.2-curl php8.2-mbstring php8.2-xml php8.2-zip php8.2-mysql php8.2-pgsql php8.2-sqlite3

    # Create symbolic link for php command
    sudo update-alternatives --set php /usr/bin/php8.2

    if command_exists php; then
        print_success "PHP installed successfully: $(php --version | head -n1)"
    else
        print_error "PHP installation failed"
        return 1
    fi
}

# Main execution
install_php