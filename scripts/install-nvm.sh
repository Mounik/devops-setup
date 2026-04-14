#!/bin/bash

# NVM Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_nvm() {
    print_info "Installing NVM..."

    if [ -d "$HOME/.nvm" ]; then
        print_success "NVM is already installed"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl

    local nvm_version
    nvm_version=$(curl -sL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -oP '"tag_name":\s*"v\K[^"]+' || echo "0.40.1")
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh" | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    if [ -d "$HOME/.nvm" ]; then
        print_success "NVM installed successfully"
        print_info "Run 'source ~/.bashrc' or restart terminal to use NVM"
    else
        print_error "NVM installation failed"
        return 1
    fi
}

install_nvm