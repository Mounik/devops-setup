#!/bin/bash

# Shared functions for DevOps installation scripts

DEVOPS_COLORS_LOADED=true

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

ensure_apt_updated() {
    if [ -z "${_APT_UPDATED:-}" ]; then
        sudo apt-get update -qq
        _APT_UPDATED=true
    fi
}