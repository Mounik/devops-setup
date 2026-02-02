#!/bin/bash

# DevOps Tools Installation Script - Main Orchestrator
# Focused on Debian/Ubuntu with modular architecture

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
LOG_FILE="/tmp/devops-tools-install.log"
DRY_RUN=false
PACK_TO_INSTALL=""
VERBOSE=false
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Print functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running on Debian/Ubuntu
check_debian() {
    if [ -f /etc/debian_version ] || [ -f /etc/lsb-release ] && grep -q "Ubuntu\|Debian" /etc/lsb-release 2>/dev/null; then
        return 0
    else
        print_error "This script currently supports only Debian/Ubuntu systems"
        return 1
    fi
}

# Define tool packs
declare -A PACKS=(
    ["tools"]="git docker gh kubectl terraform aws-cli ansible helm"
    ["security"]="vault trivy checkov"
    ["testing"]="k6 newman"
    ["languages"]="nodejs rust php python composer yarn nvm go"
    ["essential"]="git docker kubectl terraform ansible"
    ["full"]="git docker gh kubectl terraform aws-cli ansible helm vault trivy checkov k6 newman nodejs rust php python composer yarn nvm go"
)

# Execute individual script
execute_script() {
    local script_name="install-$1.sh"
    local script_path="$SCRIPT_DIR/scripts/$script_name"

    if [ "$DRY_RUN" = true ]; then
        print_info "DRY RUN: Would execute $script_path"
        return 0
    fi

    if [ ! -f "$script_path" ]; then
        print_error "Script not found: $script_path"
        return 1
    fi

    print_info "Installing $1..."
    if [ "$VERBOSE" = true ]; then
        bash "$script_path"
    else
        bash "$script_path" >/dev/null 2>&1
    fi

    if [ $? -eq 0 ]; then
        print_success "$1 installed successfully"
    else
        print_error "$1 installation failed"
        return 1
    fi
}

# Show usage
show_usage() {
    cat << EOF
DevOps Tools Installation Script

Usage: $0 [OPTIONS] [PACK|TOOL]

OPTIONS:
    -h, --help          Show this help message
    -d, --dry-run       Show what would be installed without actually installing
    -v, --verbose       Enable verbose output
    -l, --list          List available packs and tools

PACKS:
    tools               Core DevOps tools (git, docker, kubectl, terraform, etc.)
    security            Security & scanning tools (vault, trivy, checkov)
    testing             Performance & API testing (k6, newman)
    languages           Development languages (nodejs, rust, php, python, go, etc.)
    essential           Essential tools only (git, docker, kubectl, terraform, ansible)
    full                Install all tools (default)

TOOLS:
    git                 Git version control
    docker              Docker container platform
    gh                  GitHub CLI
    kubectl             Kubernetes CLI
    terraform           Terraform IaC tool
    aws-cli             AWS Command Line Interface
    ansible             Ansible automation tool
    helm                Helm package manager for Kubernetes
    vault               HashiCorp secrets management
    trivy               Container and filesystem scanner
    checkov             Infrastructure security scanner
    k6                  Performance testing tool
    newman              Postman collection runner
    nodejs              Node.js JavaScript runtime
    rust                Rust programming language
    php                 PHP scripting language
    python              Python 3 with pip and uv
    composer            PHP package manager
    yarn                JavaScript package manager
    nvm                 Node Version Manager
    go                  Go programming language

EXAMPLES:
    $0                              # Install all tools
    $0 tools                        # Install core DevOps tools
    $0 languages                    # Install development languages
    $0 git docker kubectl           # Install specific tools
    $0 --dry-run full               # Show what would be installed
    $0 --list                       # List available packs and tools

SUPPORTED DISTRIBUTIONS:
    Debian/Ubuntu

EOF
}

# List available packs and tools
list_packs_and_tools() {
    echo "Available Packs:"
    for pack in "${!PACKS[@]}"; do
        echo "  $pack                  ${PACKS[$pack]}"
    done
    echo ""
    echo "Individual Tools:"
    echo "  DevOps: git, docker, gh, kubectl, terraform, aws-cli, ansible, helm"
    echo "  Security: vault, trivy, checkov"
    echo "  Testing: k6, newman"
    echo "  Languages: nodejs, rust, php, python, composer, yarn, nvm, go"
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -l|--list)
                list_packs_and_tools
                exit 0
                ;;
            tools|security|testing|languages|essential|full|git|docker|gh|kubectl|terraform|aws-cli|ansible|helm|vault|trivy|checkov|k6|newman|nodejs|rust|php|python|composer|yarn|nvm|go)
                PACK_TO_INSTALL="$1"
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Main installation function
main() {
    print_info "Starting DevOps tools installation..."
    print_info "Log file: $LOG_FILE"

    # Check system compatibility
    check_debian

    # If no specific pack/tool requested, install all
    if [ -z "$PACK_TO_INSTALL" ]; then
        PACK_TO_INSTALL="full"
    fi

    # Determine tools to install
    local tools_to_install=""

    if [[ -n "${PACKS[$PACK_TO_INSTALL]:-}" ]]; then
        # It's a pack
        tools_to_install="${PACKS[$PACK_TO_INSTALL]}"
        print_info "Installing pack: $PACK_TO_INSTALL"
    else
        # It's an individual tool
        tools_to_install="$PACK_TO_INSTALL"
        print_info "Installing tool: $PACK_TO_INSTALL"
    fi

    # Install tools
    for tool in $tools_to_install; do
        execute_script "$tool"
        log "Completed installation of: $tool"
    done

    print_success "Installation completed!"
    print_warning "You may need to log out and log back in for group changes to take effect (e.g., for Docker)."
    print_warning "You may need to source your shell profile (source ~/.bashrc) for PATH changes to take effect."
    print_info "Installation log saved to: $LOG_FILE"
}

# Check if running as root (not recommended)
if [ "$EUID" -eq 0 ]; then
    print_warning "Running as root is not recommended. Please run as a regular user with sudo privileges."
fi

# Parse arguments and run main function
parse_args "$@"
main