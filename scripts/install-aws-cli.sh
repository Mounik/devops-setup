#!/bin/bash

# AWS CLI Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_aws_cli() {
    print_info "Installing AWS CLI..."

    if command_exists aws; then
        print_success "AWS CLI is already installed: $(aws --version | head -1)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y curl unzip

    local tmp_dir
    tmp_dir=$(mktemp -d)

    curl "https://awscli.amazonaws.com/awscli-exe-linux-$(dpkg --print-architecture).zip" -o "$tmp_dir/awscliv2.zip"
    cd "$tmp_dir"
    unzip -o awscliv2.zip
    sudo ./aws/install
    cd - > /dev/null
    rm -rf "$tmp_dir"

    if command_exists aws; then
        print_success "AWS CLI installed successfully: $(aws --version | head -1)"
    else
        print_error "AWS CLI installation failed"
        return 1
    fi
}

install_aws_cli