#!/usr/bin/env bash
#
# Nixdots Installer Script
# Automates NixOS installation from NixOS minimal USB
#
# Usage:
#   # From GitHub (curl)
#   bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)
#
#   # Local
#   ./install.sh
#   ./install.sh --host fs0ciety
#
set -euo pipefail

# ============================================
# Detectar si viene de curl o es local
# ============================================
if [[ -z "${INSTALL_SH_SOURCE:-}" ]]; then
    # Es la primera ejecución (desde curl o local)
    export INSTALL_SH_SOURCE="remote"
    
    # Si viene de curl, descargar y re-ejecutar
    if [[ "$0" == "/dev/stdin" || "$0" == *"curl"* || -f "$0" && ! -x "$0" ]]; then
        # Detectar URL del script
        SCRIPT_URL="${BASH_SOURCE[0]:-}"
        
        # Si hay argumentos, pasarlos
        if [[ $# -gt 0 ]]; then
            exec bash <(curl -sL "https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh") "$@"
        else
            exec bash <(curl -sL "https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh")
        fi
    fi
fi

# ============================================
# Configuración
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Defaults
FLAKE_URL="github:th3g3ntl3man/nixdots"
FLAKE_DIR="/home/nixos/nixdots"
HOSTNAME=""
DEVICE=""
USERNAME="th3g3ntl3man"
AUTO_CONFIRM=false

# ============================================
# Funciones de logging
# ============================================
log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }

# ============================================
# Usage
# ============================================
usage() {
    cat << EOF
Nixdots Installer - Automates NixOS installation

USAGE:
    # From GitHub (recommended for USB)
    bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

    # Local execution
    ./install.sh

OPTIONS:
    -h, --help              Show this help
    --host HOSTNAME         Host to install (fs0ciety, h4z3)
    --device DEVICE         Disk device (e.g., /dev/nvme0n1, /dev/sda)
    --flake-url URL         Flake URL (default: github:th3g3ntl3man/nixdots)
    --flake-dir PATH        Flake directory (default: /tmp/nixdots)
    --username USER         Username (default: th3g3ntl3man)
    -y, --yes               Auto-confirm all prompts
    --skip-wifi            Skip wifi configuration
    --skip-format          Skip disk formatting (just install)
    --skip-install        Skip installation (just format)

EXAMPLES:
    # Interactive (prompts for everything)
    bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

    # Non-interactive: fs0ciety (laptop)
    bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
        --host fs0ciety --device /dev/nvme0n1 -y

    # Non-interactive: h4z3 (VirtualBox)
    bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
        --host h4z3 --device /dev/sda -y

    # Local execution
    ./install.sh --host fs0ciety --device /dev/nvme0n1 -y

EOF
    exit 0
}

# ============================================
# Parse arguments
# ============================================
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        --host)
            HOSTNAME="$2"
            shift 2
            ;;
        --device)
            DEVICE="$2"
            shift 2
            ;;
        --flake-url)
            FLAKE_URL="$2"
            shift 2
            ;;
        --flake-dir)
            FLAKE_DIR="$2"
            shift 2
            ;;
        --username)
            USERNAME="$2"
            shift 2
            ;;
        -y|--yes)
            AUTO_CONFIRM=true
            shift
            ;;
        --skip-wifi)
            SKIP_WIFI=true
            shift
            ;;
        --skip-format)
            SKIP_FORMAT=true
            shift
            ;;
        --skip-install)
            SKIP_INSTALL=true
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            ;;
    esac
done

# ============================================
# Utilidades
# ============================================

# Confirmar acción peligrosa
confirm() {
    if [ "$AUTO_CONFIRM" = true ]; then
        return 0
    fi
    local prompt="${1:-Continue?}"
    local response
    read -rp "$prompt [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Verificar si es root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        exit 1
    fi
}

# Detectar disco
detect_disk() {
    log_info "Detecting available disks..."

    local disks=()
    for dev in /dev/nvme* /dev/sd[a-z]; do
        if [[ -b "$dev" ]] && [[ -d "/sys/block/$(basename "$dev")" ]]; then
            local size
            size=$(cat "/sys/block/$(basename "$dev")/size" 2>/dev/null || echo "0")
            size=$((size * 512 / 1024 / 1024 / 1024))
            if [[ $size -gt 10 ]]; then
                disks+=("$dev (${size}GB)")
            fi
        fi
    done

    if [[ ${#disks[@]} -eq 0 ]]; then
        log_error "No disks detected"
        exit 1
    fi

    log_info "Available disks:"
    select d in "${disks[@]}" "Custom..."; do
        if [[ -n "$d" ]]; then
            if [[ "$d" == "Custom..." ]]; then
                read -rp "Enter device (e.g., /dev/nvme0n1): " DEVICE
            else
                DEVICE=$(echo "$d" | awk '{print $1}')
            fi
            break
        fi
    done

    log_success "Selected disk: $DEVICE"
}

# Seleccionar host
select_host() {
    if [[ -n "$HOSTNAME" ]]; then
        return 0
    fi

    log_info "Select host to install:"

    select h in "fs0ciety (laptop)" "h4z3 (VirtualBox)"; do
        case "$h" in
            "fs0ciety"*) HOSTNAME="fs0ciety" ;;
            "h4z3"*) HOSTNAME="h4z3" ;;
        esac
        [[ -n "$HOSTNAME" ]] && break
    done

    log_success "Selected host: $HOSTNAME"
}

# Configurar wifi
setup_wifi() {
    if [[ "${SKIP_WIFI:-false}" == "true" ]]; then
        log_info "Skipping wifi configuration"
        return 0
    fi

    log_info "Configuring wifi..."

    local ssid
    read -rp "Enter WiFi network name (SSID): " ssid

    if [[ -z "$ssid" ]]; then
        log_warn "No SSID, skipping wifi"
        return 0
    fi

    if command -v nmcli &> /dev/null; then
        local password
        read -s -rp "Enter password: " password
        echo

        log_info "Connecting to $ssid..."
        nmcli device wifi connect "$ssid" password "$password" || {
            log_error "Failed to connect to wifi"
            return 1
        }
        log_success "Connected to $ssid"
    else
        log_error "nmcli not available. Please configure wifi manually."
        return 1
    fi
}

# Verificar conexión a internet
check_internet() {
    log_info "Checking internet connection..."

    if ping -c 1 -W 5 8.8.8.8 &> /dev/null; then
        log_success "Internet connection OK"
        return 0
    fi

    log_warn "No internet connection"

    if confirm "Do you want to configure wifi?"; then
        setup_wifi
    else
        log_error "Internet is required to continue"
        exit 1
    fi
}

# Instalar Nix
install_nix() {
    if command -v nix &> /dev/null; then
        log_success "Nix already installed"
        return 0
    fi

    log_info "Installing Nix..."

    sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes

    # Source nix
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null || true

    log_success "Nix installed"
}

# Clonar flake
clone_flake() {
    if [[ -d "$FLAKE_DIR" ]]; then
        log_warn "Directory $FLAKE_DIR already exists"
        if confirm "Delete and re-clone?"; then
            rm -rf "$FLAKE_DIR"
        else
            cd "$FLAKE_DIR"
            return 0
        fi
    fi

    log_info "Cloning $FLAKE_URL..."
    git clone "https://${FLAKE_URL}.git" "$FLAKE_DIR"
    cd "$FLAKE_DIR"

    log_success "Flake cloned to $FLAKE_DIR"
}

# Formatear disco con disko
format_disk() {
    if [[ "${SKIP_FORMAT:-false}" == "true" ]]; then
        log_info "Skipping disk formatting"
        return 0
    fi

    log_warn "This will ERASE all data on $DEVICE"
    if ! confirm "Continue with formatting?"; then
        log_error "Installation cancelled"
        exit 1
    fi

    log_info "Formatting disk with disko..."
    cd "$FLAKE_DIR"

    nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest \
        --no-write-lock-file -- \
        --mode format \
        --flake ".#$HOSTNAME" \
        "$DEVICE"

    log_success "Disk formatted"
}

# Instalar NixOS
install_nixos() {
    if [[ "${SKIP_INSTALL:-false}" == "true" ]]; then
        log_info "Skipping NixOS installation"
        return 0
    fi

    log_info "Installing NixOS..."
    cd "$FLAKE_DIR"

    nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest \
        --no-write-lock-file -- \
        --mode install \
        --flake ".#$HOSTNAME" \
        --hostname "$HOSTNAME" \
        --user "$USERNAME" \
        "$DEVICE"

    log_success "NixOS installed!"
}

# Mostrar resumen
show_summary() {
    echo
    echo "=============================================="
    echo -e "${GREEN}Installation complete!${NC}"
    echo "=============================================="
    echo
    echo "Hostname: $HOSTNAME"
    echo "User:     $USERNAME"
    echo "Disk:     $DEVICE"
    echo
    echo "To reboot:"
    echo "  sudo reboot"
    echo
    echo "After reboot, run:"
    echo "  home-manager switch --flake ~/Code/nix/nixdots#$USERNAME"
    echo
}

# ============================================
# Main
# ============================================
main() {
    echo
    log_info "=========================================="
    log_info "  Nixdots Installer"
    log_info "=========================================="
    echo

    check_root
    check_internet
    install_nix
    clone_flake
    select_host

    if [[ -z "$DEVICE" ]]; then
        detect_disk
    else
        log_info "Using disk: $DEVICE"
    fi

    if [[ "${SKIP_FORMAT:-false}" == "false" && "${SKIP_INSTALL:-false}" == "false" ]]; then
        format_disk
        install_nixos
        show_summary
    elif [[ "${SKIP_FORMAT:-false}" == "false" ]]; then
        format_disk
        log_info "Skipping installation as requested"
    elif [[ "${SKIP_INSTALL:-false}" == "false" ]]; then
        install_nixos
        show_summary
    fi
}

main "$@"
