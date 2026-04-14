#!/bin/bash

# Python Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_python() {
    print_info "Installing Python and uv..."

    if command_exists python3; then
        print_success "Python is already installed: $(python3 --version)"
    else
        ensure_apt_updated
        sudo apt-get install -y python3 python3-pip python3-venv python3-dev build-essential

        if command_exists python3; then
            print_success "Python installed successfully: $(python3 --version)"
        else
            print_error "Python installation failed"
            return 1
        fi
    fi

    if command_exists uv; then
        print_success "uv is already installed: $(uv --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl

    curl -LsSf https://astral.sh/uv/install.sh | sh

    export PATH="$HOME/.cargo/bin:$PATH"

    if [ -f "$HOME/.bashrc" ] && ! grep -q 'cargo/bin' ~/.bashrc 2>/dev/null; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q 'cargo/bin' ~/.zshrc 2>/dev/null; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
    fi

    if command_exists uv; then
        print_success "uv installed successfully: $(uv --version)"
    else
        print_error "uv installation failed"
        return 1
    fi
}

install_python