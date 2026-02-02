#!/bin/bash

# Go Installation Script
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

# Install Go
install_go() {
    print_info "Installing Go..."

    if command_exists go; then
        print_success "Go is already installed: $(go version)"
        return 0
    fi

    local go_version="1.21.5"
    local arch=$(dpkg --print-architecture)
    case "$arch" in
        x86_64|amd64) arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) arch="amd64" ;;
    esac

    # Install prerequisites
    sudo apt-get install -y curl wget

    # Download and install Go
    curl -L "https://go.dev/dl/go${go_version}.linux-${arch}.tar.gz" -o go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go.tar.gz
    rm go.tar.gz

    # Add to PATH if not already there
    if ! grep -q "/usr/local/go/bin" ~/.bashrc 2>/dev/null; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    fi
    export PATH=$PATH:/usr/local/go/bin

    if command_exists go; then
        print_success "Go installed successfully: $(go version)"
    else
        print_error "Go installation failed"
        return 1
    fi
}

# Main execution
install_go