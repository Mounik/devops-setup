#!/bin/bash

# AWS CLI Installation Script
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

# Install AWS CLI
install_aws_cli() {
    print_info "Installing AWS CLI..."

    if command_exists aws; then
        print_success "AWS CLI is already installed: $(aws --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y curl unzip

    # Download and install AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$(dpkg --print-architecture).zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip

    if command_exists aws; then
        print_success "AWS CLI installed successfully: $(aws --version)"
    else
        print_error "AWS CLI installation failed"
        return 1
    fi
}

# Main execution
install_aws_cli