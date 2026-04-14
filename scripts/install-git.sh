#!/bin/bash

# Git Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_git() {
    print_info "Installing Git..."

    if command_exists git; then
        print_success "Git is already installed: $(git --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y git curl

    if command_exists git; then
        print_success "Git installed successfully: $(git --version)"
    else
        print_error "Git installation failed"
        return 1
    fi
}

install_git