#!/bin/bash

# Python Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Python and uv
install_python() {
    print_info "Installing Python and uv..."

    if command_exists python3 && command_exists pip3; then
        print_success "Python is already installed: $(python3 --version)"
    else
        # Install prerequisites
        sudo apt-get update -qq
        sudo apt-get install -y python3 python3-pip python3-venv python3-dev build-essential

        if command_exists python3 && command_exists pip3; then
            print_success "Python installed successfully: $(python3 --version), pip $(pip3 --version)"
        else
            print_error "Python installation failed"
            return 1
        fi
    fi

    # Install uv (Astral's Python package installer)
    if command_exists uv; then
        print_success "uv is already installed: $(uv --version)"
        return 0
    fi

    # Install uv using the official installer
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Add to PATH for current session
    export PATH="$HOME/.cargo/bin:$PATH"

    # Add to shell profile for persistence
    if [ -f "$HOME/.bashrc" ]; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    elif [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
    fi

    if command_exists uv; then
        print_success "uv installed successfully: $(uv --version)"
    else
        print_error "uv installation failed"
        return 1
    fi
}

# Main execution
install_python