#!/bin/bash

# DevOps Tools Installation Script - Main Orchestrator
# Focused on Debian/Ubuntu with modular architecture

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

LOG_FILE="/tmp/devops-tools-install.log"
DRY_RUN=false
PACK_TO_INSTALL=""
VERBOSE=false
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLED_TOOLS=()
FAILED_TOOLS=()
CONTINUE_ON_ERROR=false

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

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

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_system() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            debian|ubuntu|linuxmint|pop)
                print_info "Detected supported system: $PRETTY_NAME"
                return 0
                ;;
            *)
                print_error "Unsupported distribution: $ID. This script supports Debian/Ubuntu and derivatives."
                print_info "You can try running with --continue-on-error to skip system checks."
                return 1
                ;;
        esac
    else
        print_error "Cannot detect operating system (/etc/os-release not found)"
        return 1
    fi
}

declare -A PACKS=(
    ["tools"]="git docker gh kubectl terraform aws-cli ansible helm jq yq"
    ["security"]="vault trivy checkov"
    ["testing"]="k6 newman"
    ["languages"]="nodejs rust php python composer yarn nvm go"
    ["essential"]="git docker kubectl terraform ansible"
    ["utils"]="jq yq htop tmux starship"
    ["fonts"]="nerd-fonts"
    ["shell"]="oh-my-zsh"
    ["cloud"]="aws-cli azure-cli gcloud"
    ["full"]="git docker gh kubectl terraform aws-cli ansible helm vault trivy checkov k6 newman nodejs rust php python composer yarn nvm go jq yq htop tmux starship oh-my-zsh nerd-fonts azure-cli gcloud"
)

declare -A DEPENDENCIES=(
    ["composer"]="php"
    ["newman"]="nodejs"
    ["yarn"]="nodejs"
)

resolve_dependencies() {
    local tool="$1"
    local deps="${DEPENDENCIES[$tool]:-}"
    if [ -n "$deps" ]; then
        echo "$deps"
    fi
}

execute_script() {
    local tool_name="$1"
    local script_name="install-${tool_name}.sh"
    local script_path="$SCRIPT_DIR/scripts/$script_name"

    for dep in $(resolve_dependencies "$tool_name"); do
        if ! command_exists "$dep" && [ "$dep" != "nvm" ]; then
            print_warning "Dependency '$dep' for '$tool_name' is not installed. Installing it first..."
            execute_script "$dep"
            if [ $? -ne 0 ]; then
                print_error "Cannot install dependency '$dep' for '$tool_name'. Skipping."
                FAILED_TOOLS+=("$tool_name (missing dep: $dep)")
                return 1
            fi
        fi
    done

    if [ "$DRY_RUN" = true ]; then
        print_info "DRY RUN: Would execute $script_path"
        INSTALLED_TOOLS+=("$tool_name (dry-run)")
        return 0
    fi

    if [ ! -f "$script_path" ]; then
        print_error "Script not found: $script_path"
        FAILED_TOOLS+=("$tool_name (script missing)")
        return 1
    fi

    print_info "Installing $tool_name..."
    local exit_code
    if [ "$VERBOSE" = true ]; then
        bash "$script_path" 2>&1 | tee -a "$LOG_FILE"
        exit_code=${PIPESTATUS[0]}
    else
        bash "$script_path" >> "$LOG_FILE" 2>&1
        exit_code=$?
    fi

    if [ $exit_code -eq 0 ]; then
        print_success "$tool_name installed successfully"
        INSTALLED_TOOLS+=("$tool_name")
    else
        print_error "$tool_name installation failed (exit code: $exit_code)"
        FAILED_TOOLS+=("$tool_name (exit: $exit_code)")
        if [ "$CONTINUE_ON_ERROR" != true ]; then
            return 1
        fi
    fi
    return $exit_code
}

show_usage() {
    cat << EOF
DevOps Tools Installation Script

Usage: $0 [OPTIONS] [PACK|TOOL...]

OPTIONS:
    -h, --help              Show this help message
    -d, --dry-run           Show what would be installed without actually installing
    -v, --verbose           Enable verbose output
    -l, --list              List available packs and tools
    -c, --continue-on-error Continue installing other tools if one fails

PACKS:
    tools               Core DevOps tools (git, docker, kubectl, terraform, etc.)
    security            Security & scanning tools (vault, trivy, checkov)
    testing             Performance & API testing (k6, newman)
    languages           Development languages (nodejs, rust, php, python, go, etc.)
    essential           Essential tools only (git, docker, kubectl, terraform, ansible)
    utils               CLI utilities (jq, yq, htop, tmux, starship)
    shell               Shell enhancements (oh-my-zsh)
    fonts               Nerd Fonts (Cascadia Code)
    cloud               Cloud CLIs (aws-cli, azure-cli, gcloud)
    full                Install all tools (default)

TOOLS:
    git                 Git version control
    docker              Docker container platform
    gh                  GitHub CLI
    kubectl             Kubernetes CLI
    terraform           Terraform IaC tool
    aws-cli             AWS Command Line Interface
    azure-cli           Azure Command Line Interface
    gcloud              Google Cloud CLI
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
    jq                  JSON processor
    yq                  YAML processor
    htop                Interactive process viewer
    tmux                Terminal multiplexer
    starship            Cross-shell prompt
    oh-my-zsh           Zsh framework
    nerd-fonts          Cascadia Code Nerd Font

EXAMPLES:
    $0                              # Install all tools
    $0 tools                        # Install core DevOps tools
    $0 languages                    # Install development languages
    $0 git docker kubectl           # Install specific tools
    $0 --dry-run full               # Show what would be installed
    $0 --list                       # List available packs and tools
    $0 --continue-on-error full     # Continue on errors

SUPPORTED DISTRIBUTIONS:
    Debian, Ubuntu, and derivatives (Linux Mint, Pop!_OS)

EOF
}

list_packs_and_tools() {
    echo "Available Packs:"
    for pack in tools security testing languages essential utils shell fonts cloud full; do
        echo "  $pack                  ${PACKS[$pack]}"
    done
    echo ""
    echo "Dependencies:"
    for tool in "${!DEPENDENCIES[@]}"; do
        echo "  $tool requires: ${DEPENDENCIES[$tool]}"
    done
}

parse_args() {
    local tools_args=()
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
            -c|--continue-on-error)
                CONTINUE_ON_ERROR=true
                shift
                ;;
            -*)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                tools_args+=("$1")
                shift
                ;;
        esac
    done

    if [ ${#tools_args[@]} -gt 1 ]; then
        PACK_TO_INSTALL="${tools_args[*]}"
    elif [ ${#tools_args[@]} -eq 1 ]; then
        PACK_TO_INSTALL="${tools_args[0]}"
    fi
}

print_summary() {
    echo ""
    echo "=========================================="
    echo -e "${BLUE}Installation Summary${NC}"
    echo "=========================================="

    if [ ${#INSTALLED_TOOLS[@]} -gt 0 ]; then
        echo -e "${GREEN}Successfully installed:${NC}"
        for tool in "${INSTALLED_TOOLS[@]}"; do
            echo -e "  ${GREEN}✓${NC} $tool"
        done
    fi

    if [ ${#FAILED_TOOLS[@]} -gt 0 ]; then
        echo ""
        echo -e "${RED}Failed installations:${NC}"
        for tool in "${FAILED_TOOLS[@]}"; do
            echo -e "  ${RED}✗${NC} $tool"
        done
    fi

    echo ""
    echo "Log file: $LOG_FILE"

    if [ ${#FAILED_TOOLS[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠ Some installations failed. Check the log for details.${NC}"
        return 1
    fi

    echo -e "${GREEN}All installations completed successfully!${NC}"
    return 0
}

main() {
    print_info "Starting DevOps tools installation..."
    print_info "Log file: $LOG_FILE"
    : > "$LOG_FILE"

    check_system

    if [ -z "$PACK_TO_INSTALL" ]; then
        PACK_TO_INSTALL="full"
    fi

    local tools_to_install=""

    local args_array=($PACK_TO_INSTALL)
    for arg in "${args_array[@]}"; do
        if [[ -n "${PACKS[$arg]:-}" ]]; then
            if [ -n "$tools_to_install" ]; then
                tools_to_install="$tools_to_install ${PACKS[$arg]}"
            else
                tools_to_install="${PACKS[$arg]}"
            fi
        else
            if [ -n "$tools_to_install" ]; then
                tools_to_install="$tools_to_install $arg"
            else
                tools_to_install="$arg"
            fi
        fi
    done

    local unique_tools=()
    local seen_tools=()
    for tool in $tools_to_install; do
        local found=false
        for s in "${seen_tools[@]:-}"; do
            if [ "$s" = "$tool" ]; then
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            unique_tools+=("$tool")
            seen_tools+=("$tool")
        fi
    done

    print_info "Tools to install: ${unique_tools[*]}"

    for tool in "${unique_tools[@]}"; do
        execute_script "$tool" || true
    done

    print_summary

    echo ""
    print_warning "You may need to log out and log back in for group changes to take effect (e.g., for Docker)."
    print_warning "You may need to source your shell profile (source ~/.bashrc) for PATH changes to take effect."
}

if [ "$EUID" -eq 0 ]; then
    print_warning "Running as root is not recommended. Please run as a regular user with sudo privileges."
fi

parse_args "$@"
main