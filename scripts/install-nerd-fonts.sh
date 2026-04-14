#!/bin/bash

# Nerd Fonts (Cascadia Code) Installation Script
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

NERD_FONT_NAME="CaskaydiaCove"
NERD_FONT_DIR="$HOME/.local/share/fonts"
NERD_FONT_VERSION="3.3.0"

install_nerd_fonts() {
    print_info "Installing Cascadia Code Nerd Font..."

    local font_file="$NERD_FONT_DIR/$NERD_FONT_NAME"NerdFont-Regular.ttf
    if [ -f "$font_file" ]; then
        print_success "Cascadia Code Nerd Font is already installed"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y curl unzip

    mkdir -p "$NERD_FONT_DIR"

    local tmp_dir
    tmp_dir=$(mktemp -d)

    curl -fLO "https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONT_VERSION}/CascadiaCode.zip" -o "$tmp_dir/CascadiaCode.zip"
    unzip -o "$tmp_dir/CascadiaCode.zip" -d "$NERD_FONT_DIR"

    rm -rf "$tmp_dir"

    fc-cache -fv "$NERD_FONT_DIR" 2>/dev/null || true

    if [ -f "$font_file" ]; then
        print_success "Cascadia Code Nerd Font installed successfully"
    else
        print_error "Cascadia Code Nerd Font installation failed"
        return 1
    fi
}

install_nerd_fonts