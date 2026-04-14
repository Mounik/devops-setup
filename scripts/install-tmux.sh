#!/bin/bash

# tmux Installation Script
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

install_tmux() {
    print_info "Installing tmux..."

    if command_exists tmux; then
        print_success "tmux is already installed: $(tmux -V)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y tmux

    if command_exists tmux; then
        print_success "tmux installed successfully: $(tmux -V)"
    else
        print_error "tmux installation failed"
        return 1
    fi
}

install_tmux