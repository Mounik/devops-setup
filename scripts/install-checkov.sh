#!/bin/bash

# Checkov Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_checkov() {
    print_info "Installing Checkov..."

    if command_exists checkov; then
        print_success "Checkov is already installed: $(checkov --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y python3 python3-pip python3-venv

    python3 -m venv ~/.checkov_venv
    source ~/.checkov_venv/bin/activate
    pip install --upgrade pip
    pip install checkov
    deactivate

    if [ -f "$HOME/.bashrc" ] && ! grep -q "checkov_venv" ~/.bashrc 2>/dev/null; then
        echo 'export PATH="$HOME/.checkov_venv/bin:$PATH"' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q "checkov_venv" ~/.zshrc 2>/dev/null; then
        echo 'export PATH="$HOME/.checkov_venv/bin:$PATH"' >> ~/.zshrc
    fi
    export PATH="$HOME/.checkov_venv/bin:$PATH"

    if command_exists checkov; then
        print_success "Checkov installed successfully: $(checkov --version)"
    else
        print_error "Checkov installation failed"
        return 1
    fi
}

install_checkov