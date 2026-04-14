#!/bin/bash

# k6 Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_k6() {
    print_info "Installing k6..."

    if command_exists k6; then
        print_success "k6 is already installed: $(k6 version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y gpg-core

    sudo install -m 0755 -d /etc/apt/keyrings
    sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
    echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list

    sudo apt-get update -qq
    sudo apt-get install -y k6

    if command_exists k6; then
        print_success "k6 installed successfully: $(k6 version)"
    else
        print_error "k6 installation failed"
        return 1
    fi
}

install_k6