#!/bin/bash

# Composer Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_composer() {
    print_info "Installing Composer..."

    if command_exists composer; then
        print_success "Composer is already installed: $(composer --version | head -1)"
        return 0
    fi

    if ! command_exists php; then
        print_info "PHP not found, installing PHP first..."
        if [ -f "$SCRIPT_DIR/install-php.sh" ]; then
            bash "$SCRIPT_DIR/install-php.sh"
        else
            print_error "PHP is required for Composer. Please install PHP first."
            return 1
        fi
    fi

    ensure_apt_updated
    sudo apt-get install -y curl php-cli php-mbstring php-xml php-curl

    local tmp_dir
    tmp_dir=$(mktemp -d)

    cd "$tmp_dir"
    curl -sS https://getcomposer.org/installer | php -- --install-dir="$tmp_dir" --filename=composer
    sudo mv "$tmp_dir/composer" /usr/local/bin/composer
    sudo chmod +x /usr/local/bin/composer
    cd - > /dev/null
    rm -rf "$tmp_dir"

    if command_exists composer; then
        print_success "Composer installed successfully: $(composer --version | head -1)"
    else
        print_error "Composer installation failed"
        return 1
    fi
}

install_composer