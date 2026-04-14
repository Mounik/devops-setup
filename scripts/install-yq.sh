#!/bin/bash

# yq Installation Script
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

install_yq() {
    print_info "Installing yq..."

    if command_exists yq; then
        print_success "yq is already installed: $(yq --version)"
        return 0
    fi

    sudo apt-get update -qq
    sudo apt-get install -y curl

    local arch=$(dpkg --print-architecture)
    case "$arch" in
        x86_64|amd64) arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) arch="amd64" ;;
    esac

    local yq_version
    yq_version=$(curl -sL https://github.com/mikefarah/yq/releases/latest 2>/dev/null | grep -oP '/tag/v\K[^"]+' || echo "4.45.1")

    curl -sL "https://github.com/mikefarah/yq/releases/download/v${yq_version}/yq_linux_${arch}.tar.gz" -o /tmp/yq.tar.gz
    tar -xzf /tmp/yq.tar.gz -C /tmp yq_linux_${arch}
    sudo mv /tmp/yq_linux_${arch} /usr/local/bin/yq
    sudo chmod +x /usr/local/bin/yq
    rm -f /tmp/yq.tar.gz

    if command_exists yq; then
        print_success "yq installed successfully: $(yq --version)"
    else
        print_error "yq installation failed"
        return 1
    fi
}

install_yq