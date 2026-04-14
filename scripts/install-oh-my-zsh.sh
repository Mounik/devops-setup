#!/bin/bash

# Oh My Zsh Installation Script
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

install_oh_my_zsh() {
    print_info "Installing Oh My Zsh..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh My Zsh is already installed"
        return 0
    fi

    sudo apt-get update -qq
    if ! command_exists zsh; then
        print_info "Installing zsh first..."
        sudo apt-get install -y zsh
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh My Zsh installed successfully"
        print_info "Run 'chsh -s \$(which zsh)' to set zsh as default shell (optional)"
    else
        print_error "Oh My Zsh installation failed"
        return 1
    fi
}

install_oh_my_zsh