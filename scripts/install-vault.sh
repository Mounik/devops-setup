#!/bin/bash

# Vault Installation Script
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

# Install Vault
install_vault() {
    print_info "Installing Vault..."
    
    if command_exists vault; then
        print_success "Vault is already installed: $(vault version)"
        return 0
    fi

    # Add HashiCorp repository
    sudo apt-get update -qq
    sudo apt-get install -y wget gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt-get update -qq
    sudo apt-get install -y vault

    if command_exists vault; then
        print_success "Vault installed successfully: $(vault version)"
    else
        print_error "Vault installation failed"
        return 1
    fi
}

# Main execution
install_vault