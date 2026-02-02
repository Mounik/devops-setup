#!/bin/bash

# Trivy Installation Script
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

# Install Trivy
install_trivy() {
    print_info "Installing Trivy..."
    
    if command_exists trivy; then
        print_success "Trivy is already installed: $(trivy --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y wget apt-transport-https gnupg lsb-release

    # Add Trivy repository
    sudo mkdir -p /etc/apt/keyrings
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /etc/apt/keyrings/trivy.gpg
    echo "deb [signed-by=/etc/apt/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

    sudo apt-get update -qq
    sudo apt-get install -y trivy

    if command_exists trivy; then
        print_success "Trivy installed successfully: $(trivy --version)"
    else
        print_error "Trivy installation failed"
        return 1
    fi
}

# Main execution
install_trivy