#!/bin/bash

# Go Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

get_latest_go_version() {
    curl -sL 'https://go.dev/VERSION?m=text' | head -1 | sed 's/go//' || echo "1.24.1"
}

install_go() {
    print_info "Installing Go..."

    if command_exists go; then
        print_success "Go is already installed: $(go version)"
        return 0
    fi

    local go_version
    go_version=$(get_latest_go_version)
    print_info "Latest Go version: $go_version"

    local arch=$(dpkg --print-architecture)
    case "$arch" in
        x86_64|amd64) arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) arch="amd64" ;;
    esac

    ensure_apt_updated
    sudo apt-get install -y curl wget

    local tmp_dir
    tmp_dir=$(mktemp -d)

    curl -L "https://go.dev/dl/go${go_version}.linux-${arch}.tar.gz" -o "$tmp_dir/go.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "$tmp_dir/go.tar.gz"
    rm -rf "$tmp_dir"

    if [ -f "$HOME/.bashrc" ] && ! grep -q "/usr/local/go/bin" ~/.bashrc 2>/dev/null; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q "/usr/local/go/bin" ~/.zshrc 2>/dev/null; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
    fi
    export PATH=$PATH:/usr/local/go/bin

    if [ -f /usr/local/go/bin/go ]; then
        print_success "Go installed successfully: $(/usr/local/go/bin/go version)"
    else
        print_error "Go installation failed"
        return 1
    fi
}

install_go