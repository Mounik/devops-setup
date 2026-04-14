#!/bin/bash

# Azure CLI Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

install_azure_cli() {
    print_info "Installing Azure CLI..."

    if command_exists az; then
        print_success "Azure CLI is already installed: $(az --version | head -1)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y curl ca-certificates apt-transport-https lsb-release gnupg

    sudo mkdir -p /etc/apt/keyrings
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
    sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

    sudo apt-get update -qq
    sudo apt-get install -y azure-cli

    if command_exists az; then
        print_success "Azure CLI installed successfully: $(az --version | head -1)"
    else
        print_error "Azure CLI installation failed"
        return 1
    fi
}

install_azure_cli