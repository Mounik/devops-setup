#!/bin/bash

# Starship Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

install_starship() {
    print_info "Installing Starship..."

    if command_exists starship; then
        print_success "Starship is already installed: $(starship --version)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y curl

    curl -sS https://starship.rs/install.sh | sh -s -- -y

    if ! grep -q "starship" ~/.bashrc 2>/dev/null; then
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q "starship" ~/.zshrc 2>/dev/null; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    fi

    if command_exists starship; then
        print_success "Starship installed successfully: $(starship --version)"
    else
        print_error "Starship installation failed"
        return 1
    fi
}

install_starship