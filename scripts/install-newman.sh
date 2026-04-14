#!/bin/bash

# Newman Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_newman() {
    print_info "Installing Newman..."

    if command_exists newman; then
        print_success "Newman is already installed: $(newman --version)"
        return 0
    fi

    if ! command_exists node || ! command_exists npm; then
        print_info "Node.js/npm not found, installing Node.js first..."
        if [ -f "$SCRIPT_DIR/install-nodejs.sh" ]; then
            bash "$SCRIPT_DIR/install-nodejs.sh"
        else
            print_error "Node.js and npm are required for Newman. Please install nodejs first."
            return 1
        fi
    fi

    npm install -g newman

    if command_exists newman; then
        print_success "Newman installed successfully: $(newman --version)"
    else
        print_error "Newman installation failed"
        return 1
    fi
}

install_newman