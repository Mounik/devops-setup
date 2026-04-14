#!/bin/bash

# htop Installation Script
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

install_htop() {
    print_info "Installing htop..."

    if command_exists htop; then
        print_success "htop is already installed: $(htop --version 2>&1 | head -1)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y htop

    if command_exists htop; then
        print_success "htop installed successfully"
    else
        print_error "htop installation failed"
        return 1
    fi
}

install_htop