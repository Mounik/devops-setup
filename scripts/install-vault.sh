#!/bin/bash

# Vault Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_vault() {
    print_info "Installing Vault..."

    if command_exists vault; then
        print_success "Vault is already installed: $(vault version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y wget gnupg software-properties-common

    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt-get update -qq
    sudo apt-get install -y vault

    if command_exists vault; then
        print_success "Vault installed successfully: $(vault version)"
    else
        print_error "Vault installation failed"
        return 1
    fi
}

install_vault