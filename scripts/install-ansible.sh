#!/bin/bash

# Ansible Installation Script
# Part of DevOps Tools Installation Suite

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_ansible() {
    print_info "Installing Ansible..."

    if command_exists ansible; then
        print_success "Ansible is already installed: $(ansible --version | head -1)"
        return 0
    fi

    ensure_apt_updated
    sudo apt-get install -y python3 python3-pip python3-venv

    python3 -m venv ~/.ansible_venv
    source ~/.ansible_venv/bin/activate
    pip install --upgrade pip
    pip install ansible
    deactivate

    if ! grep -q "ansible_venv" ~/.bashrc 2>/dev/null; then
        echo 'export PATH="$HOME/.ansible_venv/bin:$PATH"' >> ~/.bashrc
    fi
    if [ -f "$HOME/.zshrc" ] && ! grep -q "ansible_venv" ~/.zshrc 2>/dev/null; then
        echo 'export PATH="$HOME/.ansible_venv/bin:$PATH"' >> ~/.zshrc
    fi
    export PATH="$HOME/.ansible_venv/bin:$PATH"

    if command_exists ansible; then
        print_success "Ansible installed successfully: $(ansible --version | head -1)"
    else
        print_error "Ansible installation failed"
        return 1
    fi
}

install_ansible