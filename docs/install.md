# Guía de Instalación

Esta guía te permite instalar NixOS de forma automatizada usando el script de instalación.

## Índice

1. [Requisitos](#requisitos)
2. [Preparación del USB](#preparación-del-usb)
3. [Uso del Script de Instalación](#uso-del-script-de-instalación)
   - [Desde GitHub (recomendado)](#opción-1-desde-github-recomendado---funciona-desde-usb)
   - [Local](#opción-2-local-si-ya-tienes-el-repo-clonado)
   - [Opciones del script](#opciones-del-script)
4. [Instalación Manual](#instalación-manual-sin-script)
5. [Después de la Instalación](#después-de-la-instalación)
6. [Troubleshooting](#troubleshooting)
7. [Recuperación](#recuperación)
8. [Estructura del Disco](#estructura-del-disco)

---

## Requisitos

1. USB con NixOS Minimal (bootable)
2. Conexión a internet (WiFi o ethernet)
3. Disco destino con al menos 20GB libres

---

## Preparación del USB

### 1. Descargar NixOS Minimal

```bash
# Descargar la última versión
wget https://nixos.org/download-nix-os-direct/latest-nixos-minimal-x86_64-linux.iso

# O versión específica (reemplazar con la versión deseada)
wget https://channels.nixos.org/nixos-25.11/latest-nixos-minimal-x86_64-linux.iso
```

### 2. Flashear USB

```bash
# Identificar el dispositivo USB
lsblk

# Flashear (¡CUIDADO! /dev/sdX es el USB, no tu disco duro)
sudo dd if=nixos-minimal-*.iso of=/dev/sdX bs=4M status=progress
sync
```

---

## Uso del Script de Instalación

### Opción 1: Desde GitHub (recomendado - funciona desde USB)

El script se ejecuta directamente desde GitHub sin necesidad de clonar el repo:

```bash
# Interactivo (te preguntará todo)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

# No interactivo: fs0ciety (laptop)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host fs0ciety --device /dev/nvme0n1 -y

# No interactivo: h4z3 (VirtualBox)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host h4z3 --device /dev/sda -y

# No interactivo: wh1t3r0s3 (VMware Workstation)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host wh1t3r0s3 --device /dev/sda -y
```

### Opción 2: Local (si ya tienes el repo clonado)

```bash
# Clonar el repo primero
git clone https://github.com/th3g3ntl3man/nixdots.git ~/Code/nix/nixdots
cd ~/Code/nix/nixdots

# Interactivo
sudo ./install.sh

# No interactivo
sudo ./install.sh --host fs0ciety --device /dev/nvme0n1 -y
```

El script te guiará paso a paso:
1. Configura WiFi (si es necesario)
2. Instala Nix si no está
3. Clona el flake
4. Detecta discos disponibles
5. Selecciona el host (fs0ciety o h4z3)
6. Confirma antes de formatear
7. Instala NixOS

### Opciones del script

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `--host HOSTNAME` | Host a instalar (fs0ciety o h4z3) | `--host fs0ciety` |
| `--device DEVICE` | Disco destino | `--device /dev/nvme0n1` |
| `--flake-url URL` | URL del flake | `--flake-url github:user/repo` |
| `--flake-dir PATH` | Directorio del flake (default: /tmp/nixdots) | `--flake-dir /opt/nixdots` |
| `--username USER` | Usuario (default: th3g3ntl3man) | `--username miusuario` |
| `-y, --yes` | Auto-confirmar todo | `-y` |
| `--skip-wifi` | Saltar configuración wifi | `--skip-wifi` |
| `--skip-format` | Solo instalar (no formatear disco) | `--skip-format` |
| `--skip-install` | Solo formatear (no instalar sistema) | `--skip-install` |
| `-h, --help` | Mostrar ayuda | `--help` |

### Ejemplos completos

```bash
# Instalación completa fs0ciety (laptop)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host fs0ciety --device /dev/nvme0n1 -y

# Instalación completa h4z3 (VirtualBox)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host h4z3 --device /dev/sda -y

# Instalación completa wh1t3r0s3 (VMware Workstation)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host wh1t3r0s3 --device /dev/sda -y

# Solo formatear disco (útil para testing)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host fs0ciety --device /dev/nvme0n1 -y --skip-install

# Usar un fork propio
bash <(curl -sL https://raw.githubusercontent.com/miusuario/mi-nixdots/main/install.sh) \
    --host fs0ciety --device /dev/nvme0n1 -y --flake-url github:miusuario/mi-nixdots
```

---

## Instalación Manual (sin script)

## Instalación Manual (sin script)

Si prefieres hacerlo paso a paso:

### 1. Boot desde USB

### 2. Conectar a internet

```bash
# WiFi
ip link
iwctl
# o
nmcli device wifi list
nmcli device wifi connect "SSID" password "PASSWORD"

# Ethernet
dhcpcd
```

### 3. Clonar el flake

```bash
git clone https://github.com/th3g3ntl3man/nixdots.git ~/Code/nix/nixdots
cd ~/Code/nix/nixdots
```

### 4. Instalar Nix (si no está)

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### 5. Formatear disco con disko

```bash
# fs0ciety (laptop)
sudo disko --mode format --flake .#fs0ciety --disk /dev/nvme0n1

# h4z3 (VirtualBox)
sudo disko --mode format --flake .#h4z3 --disk /dev/sda
```

### 6. Instalar NixOS

```bash
# fs0ciety
sudo nixos-install --flake .#fs0ciety

# h4z3
sudo nixos-install --flake .#h4z3
```

### 7. Reiniciar

```bash
sudo reboot
```

## Después de la Instalación

### Configurar Home Manager

```bash
# Después del primer boot
home-manager switch --flake ~/Code/nix/nixdots#th3g3ntl3man
```

### Actualizar el sistema

```bash
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#fs0ciety
```

## Troubleshooting

### Error: "git: command not found"

```bash
# Instalar git en el live USB
nix-env -iA nixpkgs.git
```

### Error: "No se puede conectar a github"

```bash
# Configurar git para usar https en lugar de ssh
git config --global url."https://github.com/".insteadOf "git@github.com:"

# O configurar proxy si estás detrás de un firewall
```

### Error: "disko: permission denied"

```bash
# Ejecutar como root
sudo -i
```

### Error: "UUID already exists"

Los UUIDs ya existen en el disco. Puedes:
1. Usar un disco nuevo
2. Zeroizar el disco primero:
   ```bash
   sudo dd if=/dev/zero of=/dev/nvme0n1 bs=1M status=progress
   ```

### No hay sonido después de instalar

```bash
# Reiniciar pipewire
systemctl --user restart pipewire
```

### WiFi no funciona

```bash
# Instalar firmware
sudo nixos-rebuild switch --flake .#fs0ciety
```

## Recuperación

Si algo sale mal:

### Boot desde USB nuevamente

```bash
# Montar particiones
sudo mount /dev/nvme0n1p2 /mnt
sudo mount /dev/nvme0n1p1 /mnt/boot

# Chroot
sudo nixos-enter --root /mnt
```

### Regenerar hardware-configuration

```bash
sudo nixos-generate-config
sudo nixos-install --flake .#fs0ciety --no-root-passwd
```

## Estructura del Disco

### fs0ciety (NVMe)

```
/dev/nvme0n1 (GPT)
├── /dev/nvme0n1p1 → /boot (vfat, 512MiB)
└── /dev/nvme0n1p2 → / (ext4, resto)
```

### h4z3 (VirtualBox)

```
/dev/sda (GPT)
├── /dev/sda1 → /boot (vfat, 512MiB)
└── /dev/sda2 → / (ext4, resto)
```

### wh1t3r0s3 (VMware)

```
/dev/sda (GPT)
├── /dev/sda1 → /boot (vfat, 512MiB)
└── /dev/sda2 → / (ext4, resto)
```

## Véase también

- [docs/disko.md](./disko.md) - Configuración de disco
- [docs/h4z3.md](./h4z3.md) - Host VirtualBox
- [docs/wh1t3r0s3.md](./wh1t3r0s3.md) - Host VMware Workstation
- [QUICKREF.md](../QUICKREF.md) - Comandos útiles
