#!/bin/bash

# Node.js Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_nodejs() {
    print_info "Installing Node.js..."

    if command_exists node && command_exists npm; then
        print_success "Node.js is already installed: $(node --version), npm $(npm --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl

    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs

    if command_exists node && command_exists npm; then
        print_success "Node.js installed successfully: $(node --version), npm $(npm --version)"
    else
        print_error "Node.js installation failed"
        return 1
    fi
}

install_nodejs