#!/bin/bash

# Docker Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_docker() {
    print_info "Installing Docker..."

    if command_exists docker; then
        print_success "Docker is already installed: $(docker --version)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y ca-certificates curl gnupg

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -qq
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo systemctl start docker || true
    sudo systemctl enable docker || true
    sudo usermod -aG docker "$USER" 2>/dev/null || true

    if command_exists docker; then
        print_success "Docker installed successfully: $(docker --version)"
    else
        print_error "Docker installation failed"
        return 1
    fi
}

install_docker