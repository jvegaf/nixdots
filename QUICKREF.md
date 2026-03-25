# Quick Reference / Referencia Rápida

## Atajos de Teclado Principales

### Hyprland
```
Super + Return     → Terminal (alacritty)
Super + D          → Menú de apps (wofi)
Super + L          → Bloquear pantalla
Super + Shift + C  → Cerrar ventana
Super + Shift + Q  → Salir de Hyprland
Super + 1-0        → Cambiar workspace
Super + Shift + 1-0 → Mover ventana a workspace
Super + F          → Pantalla completa
Super + Shift + F  → Pantalla completa (fake)
Super + P          → Pinch/picker de color
Super + N          → Notificaciones (swaync)
Super + W          → Abrir libros (PDF/epub)
Super + V          → Clipboard manager
Print              → Captura de pantalla (área)
Super + Print      → Captura de pantalla (ventana)
```

### Tmux
```
Alt + a, luego... → Prefix (equivalente a Ctrl+b)
Alt + h/j/k/l      → Cambiar pane
Alt + ←/→/↑/↓      → Cambiar pane
Alt + Shift + ←/→/↑/↓ → Resize pane
Ctrl + 1-9         → Ir a ventana
Alt + r            → Recargar config
```

### Zsh/Vim-style
```
Ctrl + p/n         → Historial de comandos
Ctrl + u           → Borrar línea
Ctrl + a           → Inicio de línea
Ctrl + e           → Fin de línea
```

## Comandos Útiles

```bash
# Rebuilds
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#fs0ciety    # Host principal
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#h4z3        # Host VirtualBox
sudo nixos-rebuild switch --flake ~/Code/nix/nixdots#wh1t3r0s3   # Host VMware
home-manager switch --flake ~/Code/nix/nixdots#th3g3ntl3man
nix flake update

# Testing
nix flake check
nix build ~/Code/nix/nixdots#homeConfigurations.th3g3ntl3man.activationPackage
./result/activate

# VirtualBox h4z3
nix build .#nixosConfigurations.h4z3.config.system.build.isoImage

# VMware wh1t3r0s3
nix build .#nixosConfigurations.wh1t3r0s3.config.system.build.isoImage
# Output: result/iso/

# Instalación (desde USB con curl)
bash <(curl -sL https://raw.githubusercontent.com/th3g3ntl3man/nixdots/main/install.sh)

# O local
./install.sh --host fs0ciety -y
# Ver docs/install.md para más opciones


# Info
nix flake show
nix repl '<nixpkgs>'  # Explorar paquetes
```

## Estructura de Directorios Nix

```
~/Code/nix/nixdots/
├── flake.nix              # Inputs y outputs del flake
├── install.sh             # Script de instalación (ejecutable con curl)
├── docs/                  # Documentación
│   ├── disko.md          # Guía de Disko
│   ├── h4z3.md           # Host VirtualBox
│   └── install.md        # Guía de instalación completa
├── home-manager/
│   ├── home.nix          # Entry point
│   ├── home-packages.nix # Paquetes usuario
│   └── modules/          # Configuraciones
│       ├── alacritty.nix
│       ├── bat.nix
│       ├── dunst.nix
│       ├── fastfetch/
│       ├── git.nix
│       ├── gtk.nix
│       ├── hyprland/
│       ├── qt.nix
│       ├── tmux.nix
│       ├── waybar/
│       ├── wezterm/
│       ├── zsh.nix
│       └── ...
└── hosts/
    ├── fs0ciety/         # Host principal (laptop)
    │   ├── configuration.nix
    │   ├── disko.nix     # Configuración de disco (disko)
    │   ├── hardware-configuration.nix
    │   └── local-packages.nix
    └── h4z3/             # Host VirtualBox (testing)
        ├── configuration.nix
        ├── disko.nix
        ├── hardware-configuration.nix
        └── local-packages.nix
```

## Disko (Particionado Declarativo)

```bash
# Formatear disco (CUIDADO: destructivo)
sudo disko --mode format --flake ~/Code/nix/nixdots#fs0ciety

# Solo particionar
sudo disko --mode create --flake ~/Code/nix/nixdots#fs0ciety

# Montar particiones
sudo disko --mode mount --flake ~/Code/nix/nixdots#fs0ciety

# Desmontar
sudo disko --mode umount --flake ~/Code/nix/nixdots#fs0ciety
```

Más info en `docs/disko.md`

## Paquetes Principales

| Paquete | Descripción |
|---------|-------------|
| `alacritty` | Terminal |
| `neovim` | Editor |
| `zsh` | Shell |
| `tmux` | Multiplexor |
| `starship` | Prompt |
| `delta` | Git diff |
| `lazygit` | Git UI |
| `yazi` | File manager |
| `wofi` | App launcher |
| `waybar` | Status bar |
| `hyprland` | WM |
| `firefox` | Browser |

## Colores Catppuccin Mocha

```
🟪 Mauve    #cba6f7   (comentarios, keywords)
🔵 Blue      #89b4fa   (funciones, strings)
🟢 Green     #a6e3a1   (strings, success)
🟡 Yellow    #f9e2af   (variables, warnings)
🩷 Pink      #f5c2e7   (special, headers)
🔴 Red       #f38ba8   (errors, deletions)
⚪ Overlay   #6c7086   (secondary text)
⚫ Base      #1e1e28   (background)
```

## Troubleshooting

### "command not found" después de rebuild
```bash
# Verificar que el paquete está instalado
grep -r "nombre-paquete" ~/Code/nix/nixdots/home-manager/home-packages.nix

# Si no está, agregarlo y rebuild
```

### Config no toma efecto
```bash
# Forzar re-activación
home-manager switch --flake ~/Code/nix/nixdots#th3g3ntl3man -L

# Ver errores
journalctl -u home-manager-th3g3ntl3man
```

### Hyprland no inicia
```bash
# Ver logs
cat ~/.hyprland/hyprland.log

# Verificar config
hyprctl version
```

### Theme no aplica
```bash
# Para GTK
gsettings get org.gnome.desktop.interface gtk-theme

# Para Qt
echo $QT_QPA_PLATFORMTHEME

# Para Waybar
pkill waybar && waybar &
```

## Links Útiles

### Documentación Local
- [docs/install.md](../docs/install.md) - Guía de instalación completa
- [docs/disko.md](../docs/disko.md) - Configuración de disco con Disko
- [docs/h4z3.md](../docs/h4z3.md) - Host VirtualBox
- [docs/wh1t3r0s3.md](../docs/wh1t3r0s3.md) - Host VMware Workstation

### Documentación Externa
- [Home Manager Manual](https://nix-community.github.io/home-manager/index.html)
- [Hyprland Wiki](https://wiki.hyrland.org/)
- [NixOS Search](https://search.nixos.org/options)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Disko GitHub](https://github.com/nix-community/disko)
