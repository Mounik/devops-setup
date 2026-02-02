#!/bin/bash

# Helm Installation Script
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

# Install Helm
install_helm() {
    print_info "Installing Helm..."

    if command_exists helm; then
        print_success "Helm is already installed: $(helm version --short)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get install -y curl

    # Download and install Helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    if command_exists helm; then
        print_success "Helm installed successfully: $(helm version --short)"
    else
        print_error "Helm installation failed"
        return 1
    fi
}

# Main execution
install_helm