#!/bin/bash

# Helm Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_helm() {
    print_info "Installing Helm..."

    if command_exists helm; then
        print_success "Helm is already installed: $(helm version --short)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl

    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    if command_exists helm; then
        print_success "Helm installed successfully: $(helm version --short)"
    else
        print_error "Helm installation failed"
        return 1
    fi
}

install_helm