#!/bin/bash

# gcloud (Google Cloud CLI) Installation Script
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

install_gcloud() {
    print_info "Installing Google Cloud CLI..."

    if command_exists gcloud; then
        print_success "gcloud is already installed: $(gcloud --version | head -1)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y curl apt-transport-https ca-certificates gnupg

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/cloud-google.gpg

    echo "deb [signed-by=/etc/apt/keyrings/cloud-google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

    sudo apt-get update -qq
    sudo apt-get install -y google-cloud-cli

    if command_exists gcloud; then
        print_success "gcloud installed successfully: $(gcloud --version | head -1)"
    else
        print_error "gcloud installation failed"
        return 1
    fi
}

install_gcloud