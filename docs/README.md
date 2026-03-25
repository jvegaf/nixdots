# Documentación de Nixdots

## Índice

| Documento | Descripción |
|-----------|-------------|
| [install.md](./install.md) | Guía completa de instalación desde USB |
| [disko.md](./disko.md) | Configuración de disco declarativo con Disko |
| [h4z3.md](./h4z3.md) | Host VirtualBox (X11 + AwesomeWM) |

---

## Quick Start

### Instalación Rápida

```bash
# Desde USB (NixOS Minimal)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

# O con opciones
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh) \
    --host fs0ciety --device /dev/nvme0n1 -y
```

Más info en [install.md](./install.md)

---

## Estructura del Proyecto

```
nixdots/
├── flake.nix              # Inputs y outputs del flake
├── install.sh             # Script de instalación automática
├── QUICKREF.md           # Referencia rápida
├── README.md             # Este archivo
├── docs/                 # Documentación
│   ├── README.md         # Índice de documentación
│   ├── install.md        # Guía de instalación
│   ├── disko.md          # Configuración de disco
│   └── h4z3.md          # Host VirtualBox
├── nixos/                # Módulos de NixOS
│   └── modules/          # Módulos NixOS
│       ├── awesome.nix   # X11 + AwesomeWM
│       ├── hyprland.nix # Wayland + Hyprland
│       └── ...
├── home-manager/         # Configuración de usuario
└── hosts/               # Hosts
    ├── fs0ciety/        # Host principal (laptop)
    │   ├── configuration.nix
    │   ├── disko.nix
    │   └── hardware-configuration.nix
    └── h4z3/            # Host VirtualBox
        ├── configuration.nix
        ├── disko.nix
        └── hardware-configuration.nix
```

---

## Hosts

### fs0ciety (Laptop)

- **Display Server**: Wayland
- **Window Manager**: Hyprland
- **Disco**: `/dev/nvme0n1` (NVMe)
- **Propósito**: Uso diario

### h4z3 (VirtualBox)

- **Display Server**: X11
- **Window Manager**: AwesomeWM
- **Display Manager**: LightDM
- **Disco**: `/dev/sda` (SATA virtual)
- **Propósito**: Testing

---

## Módulos NixOS

| Módulo | Descripción |
|--------|-------------|
| `awesome.nix` | X11 + AwesomeWM (h4z3) |
| `hyprland.nix` | Wayland + Hyprland (fs0ciety) |
| `audio.nix` | Configuración de audio (PipeWire) |
| `bluetooth.nix` | Bluetooth |
| `boot.nix` | Configuración de boot |
| `env.nix` | Variables de entorno |
| `home-manager.nix` | Integración Home Manager |
| `kernel.nix` | Configuración del kernel |
| `mime.nix` | Tipos MIME |
| `net.nix` | Configuración de red |
| `nh.nix` | Herramienta de rebuild |
| `nix.nix` | Configuración de Nix |
| `timezone.nix` | Zona horaria |
| `user.nix` | Usuario del sistema |
| `zram.nix` | Swap en RAM |

---

## Comandos Útiles

### Rebuild del sistema

```bash
# fs0ciety
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#fs0ciety

# h4z3
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#h4z3
```

### Home Manager

```bash
home-manager switch --flake ~/Code/nix/nixdots#th3g3ntl3man
```

### Actualizar flake

```bash
nix flake update
```

### Generar ISO (h4z3)

```bash
nix build .#nixosConfigurations.h4z3.config.system.build.isoImage
```

---

## Véase también

- [QUICKREF.md](../QUICKREF.md) - Referencia rápida de comandos
- [NixOS Wiki](https://nixos.wiki/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Disko GitHub](https://github.com/nix-community/disko)
