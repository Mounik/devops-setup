#!/bin/bash

# kubectl Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_kubectl() {
    print_info "Installing kubectl..."

    if command_exists kubectl; then
        print_success "kubectl is already installed: $(kubectl version --client 2>/dev/null | head -1 || echo 'installed')"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg

    sudo install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt-get update -qq
    sudo apt-get install -y kubectl

    if command_exists kubectl; then
        print_success "kubectl installed successfully: $(kubectl version --client 2>/dev/null | head -1 || echo 'installed')"
    else
        print_error "kubectl installation failed"
        return 1
    fi
}

install_kubectl