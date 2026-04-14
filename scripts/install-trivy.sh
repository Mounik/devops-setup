#!/bin/bash

# Trivy Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_trivy() {
    print_info "Installing Trivy..."

    if command_exists trivy; then
        print_success "Trivy is already installed: $(trivy --version | head -1)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y wget apt-transport-https gnupg lsb-release

    sudo install -m 0755 -d /etc/apt/keyrings
    wget -qO- https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /etc/apt/keyrings/trivy.gpg
    echo "deb [signed-by=/etc/apt/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list

    sudo apt-get update -qq
    sudo apt-get install -y trivy

    if command_exists trivy; then
        print_success "Trivy installed successfully: $(trivy --version | head -1)"
    else
        print_error "Trivy installation failed"
        return 1
    fi
}

install_trivy