#!/bin/bash

# GitHub CLI Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_gh() {
    print_info "Installing GitHub CLI..."

    if command_exists gh; then
        print_success "GitHub CLI is already installed: $(gh --version | head -1)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl

    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt-get update -qq
    sudo apt-get install -y gh

    if command_exists gh; then
        print_success "GitHub CLI installed successfully: $(gh --version | head -1)"
    else
        print_error "GitHub CLI installation failed"
        return 1
    fi
}

install_gh