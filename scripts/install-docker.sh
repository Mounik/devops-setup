#!/bin/bash

# Docker Installation Script
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

# Install Docker
install_docker() {
    print_info "Installing Docker..."

    if command_exists docker; then
        print_success "Docker is already installed: $(docker --version)"
        return 0
    fi

    # Install prerequisites
    sudo apt-get update -qq
    sudo apt-get install -y ca-certificates curl gnupg

    # Add Docker's official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Set up the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -qq
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Start and enable Docker service
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER 2>/dev/null || true

    if command_exists docker; then
        print_success "Docker installed successfully: $(docker --version)"
    else
        print_error "Docker installation failed"
        return 1
    fi
}

# Main execution
install_docker