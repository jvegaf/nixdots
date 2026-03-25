# Host wh1t3r0s3 - VMware Workstation Environment

## Overview

Host **wh1t3r0s3** es un host de NixOS diseñado para pruebas en VMware Workstation 16+. Permite desarrollar y testear la configuración del flake en un entorno virtualizado antes de aplicarla al host principal (`fs0ciety`).

**Este host usa X11 + AwesomeWM** en lugar de Wayland + Hyprland (como fs0ciety).

## Quick Start

### 1. Construir imagen ISO

```bash
cd ~/Code/nix/nixdots
nix build .#nixosConfigurations.wh1t3r0s3.config.system.build.isoImage
```

La ISO se generará en `result/iso/`

### 2. Crear VM en VMware Workstation

1. Nueva máquina virtual:
   - **Nombre**: wh1t3r0s3
   - **Tipo**: Linux
   - **Versión**: Other Linux 64-bit
   - **RAM**: 4096 MB (mínimo 2048 MB)
   - **CPU**: 2 cores

2. Almacenamiento:
   - Disco duro: 20 GB (provisionado fino)
   - SCSI (Recomendado) o SATA

3. Red:
   - Adaptador 1: NAT (para acceso a internet)

4. Opciones de máquina virtual:
   - EFI habilitado (recomendado)
   - Virtualize Intel VT-x/EPT o AMD-V

### 3. Arrancar y configurar

1. Boot desde la ISO
2. Login como root (sin contraseña en el ISO minimal)
3. Ejecutar:
   ```bash
   mount /dev/sda1 /mnt
   nixos-install
   reboot
   ```

## Estructura de Archivos

```
hosts/wh1t3r0s3/
├── configuration.nix           # Configuración principal del host
├── disko.nix                   # Configuración de disco (disko)
├── hardware-configuration.nix # Configuración de hardware (VMware)
└── local-packages.nix          # Paquetes específicos del host
```

## Módulos de VMware

| Módulo | Descripción |
|--------|-------------|
| `vmwgfx` | Driver de video VMware SVGA |
| `vmw_balloon` | Memory ballooning |
| `vmw_vmci` | VMware Communication Interface |
| `vsock` | Socket de comunicación VM-Host |

## Diferencias con otros hosts

| Característica | fs0ciety | h4z3 | wh1t3r0s3 |
|----------------|----------|------|-----------|
| Display Server | Wayland | X11 | X11 |
| Window Manager | Hyprland | AwesomeWM | AwesomeWM |
| Display Manager | none | LightDM | LightDM |
| Hardware | Laptop real | VirtualBox | VMware |
| Propósito | Uso diario | Testing VB | Testing VMware |

## Comandos

### Instalación con script

```bash
# Interactivo
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

# No interactivo
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host wh1t3r0s3 --device /dev/sda -y
```

### Rebuild desde dentro de la VM

```bash
# Dentro de wh1t3r0s3
sudo nixos-rebuild switch --flake /home/th3g3ntl3man/Code/nix/nixdots#wh1t3r0s3
```

### Generar ISO

```bash
nix build .#nixosConfigurations.wh1t3r0s3.config.system.build.isoImage
```

## Disko

El host wh1t3r0s3 usa disko para particionar el disco:

```nix
disko.devices = {
  disk = {
    main = {
      device = "/dev/sda";  # Disco SCSI virtual de VMware
      content = {
        partitions = {
          boot = { start = "1MiB", end = "512MiB", type = "EF00" };
          root = { start = "512MiB", end = "100%" };
        };
      };
    };
  };
};
```

### Comandos para wh1t3r0s3

```bash
# Formatear disco virtual
sudo disko --mode format --flake ~/Code/nix/nixdots#wh1t3r0s3

# Instalar NixOS
sudo nixos-install --flake ~/Code/nix/nixdots#wh1t3r0s3
```

## Troubleshooting

### La VM no bootea desde la ISO

1. Verificar que la ISO está correctamente attached
2. En VM Settings > Options, verificar orden de boot
3. Probar habilitar/deshabilitar EFI
4. Verificar que VT-x/AMD-V está habilitado en BIOS

### Error de resolución

```bash
# En la VM
sudo systemctl restart display-manager
```

### No hay red

```bash
# Verificar configuración NAT
ip addr show
ping -c 3 8.8.8.8
```

### VMware Tools no funciona

VMware Tools no es necesario en NixOS porque el kernel ya tiene los módulos vmwgfx. Para características adicionales:

```bash
# Instalar open-vm-tools (opcional)
environment.systemPackages = with pkgs; [
  open-vm-tools
];
```

### Slow performance

- Aumentar RAM a 4GB+
- Asignar más cores de CPU
- Usar disco SCSI en lugar de SATA
- Habilitar aceleración 3D si está disponible

## Notas

- ** stateVersion**: 25.11 (heredado del flake)
- **Usuario**: `th3g3ntl3man` (definido en flake.nix)
- Los UUIDs en `hardware-configuration.nix` son placeholders

## Véase también

- [docs/install.md](./install.md) - Guía de instalación
- [docs/disko.md](./disko.md) - Configuración de disco
- [docs/h4z3.md](./h4z3.md) - Host VirtualBox
