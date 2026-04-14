#!/bin/bash

# Rust Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_rust() {
    print_info "Installing Rust..."

    if [ -f "$HOME/.cargo/env" ] && command_exists rustc; then
        source "$HOME/.cargo/env"
        print_success "Rust is already installed: $(rustc --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl build-essential

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    source "$HOME/.cargo/env"

    if [ -f "$HOME/.bashrc" ] && ! grep -q 'cargo/env' ~/.bashrc 2>/dev/null; then
        echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q 'cargo/env' ~/.zshrc 2>/dev/null; then
        echo 'source "$HOME/.cargo/env"' >> ~/.zshrc
    fi

    if command_exists rustc; then
        print_success "Rust installed successfully: $(rustc --version)"
    else
        print_error "Rust installation failed"
        return 1
    fi
}

install_rust