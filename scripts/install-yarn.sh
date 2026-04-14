#!/bin/bash

# Yarn Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_yarn() {
    print_info "Installing Yarn..."

    if command_exists yarn; then
        print_success "Yarn is already installed: $(yarn --version)"
        return 0
    fi

    if ! command_exists node || ! command_exists npm; then
        print_info "Node.js/npm not found, installing Node.js first..."
        if [ -f "$SCRIPT_DIR/install-nodejs.sh" ]; then
            bash "$SCRIPT_DIR/install-nodejs.sh"
        else
            print_error "Node.js and npm are required for Yarn. Please install nodejs first."
            return 1
        fi
    fi

    npm install -g yarn

    if command_exists yarn; then
        print_success "Yarn installed successfully: $(yarn --version)"
    else
        print_error "Yarn installation failed"
        return 1
    fi
}

install_yarn