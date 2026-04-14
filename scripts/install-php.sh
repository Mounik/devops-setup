#!/bin/bash

# PHP Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

get_distro_id() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

install_php() {
    print_info "Installing PHP..."

    if command_exists php; then
        print_success "PHP is already installed: $(php --version | head -n1)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y ca-certificates curl gnupg software-properties-common lsb-release

    local distro
    distro=$(get_distro_id)

    if [ "$distro" = "ubuntu" ] || [ "$distro" = "linuxmint" ] || [ "$distro" = "pop" ]; then
        sudo add-apt-repository -y ppa:ondrej/php
        sudo apt-get update -qq
        sudo apt-get install -y php8.3 php8.3-cli php8.3-curl php8.3-mbstring php8.3-xml php8.3-zip php8.3-mysql php8.3-pgsql php8.3-sqlite3 php8.3-gd php8.3-intl php8.3-bcmath
    else
        curl -fsSL https://packages.sury.org/php/apt.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sury-php.gpg
        echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
        sudo apt-get update -qq
        sudo apt-get install -y php8.3 php8.3-cli php8.3-curl php8.3-mbstring php8.3-xml php8.3-zip php8.3-mysql php8.3-pgsql php8.3-sqlite3 php8.3-gd php8.3-intl php8.3-bcmath
    fi

    if command_exists php; then
        print_success "PHP installed successfully: $(php --version | head -n1)"
    else
        print_error "PHP installation failed"
        return 1
    fi
}

install_php