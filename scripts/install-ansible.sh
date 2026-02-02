#!/bin/bash

# Ansible Installation Script
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

# Install Ansible
install_ansible() {
    print_info "Installing Ansible..."

    if command_exists ansible; then
        print_success "Ansible is already installed: $(ansible --version | head -n1)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y python3 python3-pip python3-venv

    # Create and activate virtual environment
    python3 -m venv ~/.ansible_venv
    source ~/.ansible_venv/bin/activate

    # Install Ansible via pip
    pip install --upgrade pip
    pip install ansible

    # Add to PATH if not already there
    if ! grep -q "ansible_venv" ~/.bashrc 2>/dev/null; then
        echo 'export PATH="$HOME/.ansible_venv/bin:$PATH"' >> ~/.bashrc
    fi

    if command_exists ansible; then
        print_success "Ansible installed successfully: $(ansible --version | head -n1)"
    else
        print_error "Ansible installation failed"
        return 1
    fi
}

# Main execution
install_ansible