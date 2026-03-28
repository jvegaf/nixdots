# NixDots - Configuración de Dotfiles en Nix

Mi configuración de sistema y dotfiles migrada a Nix flakes con Home Manager.

## 📁 Estructura del Proyecto

```
nixdots/
├── flake.nix                 # Configuración principal del flake
├── home-manager/
│   ├── home.nix             # Punto de entrada de home-manager
│   ├── home-packages.nix    # Paquetes instalados por usuario
│   └── modules/             # Módulos de configuración
│       ├── default.nix      # Importa todos los módulos
│       ├── alacritty.nix    # Terminal Alacritty
│       ├── bat.nix          # Visor de archivos con sintaxis
│       ├── chromium.nix      # Navegador Chromium
│       ├── dunst.nix        # Demonio de notificaciones
│       ├── eza.nix          # Reemplazo moderno de ls
│       ├── fastfetch/       # Configuración de fastfetch
│       ├── fastfetch.nix
│       ├── firefox.nix      # Navegador Firefox
│       ├── fontconfig.nix   # Configuración de fuentes
│       ├── git.nix          # Configuración de Git
│       ├── gtk.nix          # Temas GTK2/GTK3
│       ├── hyprland/        # Gestor de ventanas Hyprland
│       │   ├── binds.nix    # Atajos de teclado
│       │   ├── hypridle.nix # Suspensión/bloqueo
│       │   ├── hyprlock.nix # Pantalla de bloqueo
│       │   ├── hyprpaper.nix # Papel tapiz
│       │   └── main.nix     # Configuración principal
│       ├── ideavim.nix      # Vim para JetBrains IDEs
│       ├── lazygit.nix      # UI de Git en terminal
│       ├── neovim.nix       # Editor de texto Neovim
│       ├── qt.nix           # Temas Qt5/Qt6
│       ├── ranger.nix        # Gestor de archivos terminal
│       ├── starship.nix      # Prompt de shell
│       ├── stylix.nix        # Temas del sistema (Stylix)
│       ├── swaync/          # Notificaciones de Sway
│       ├── tmux.nix         # Multiplexor de terminal
│       ├── waybar/          # Barra de estado de Wayland
│       ├── wezterm/         # Config de Wezterm
│       ├── wezterm.nix
│       ├── wofi/            # Menú de aplicaciones (Wofi)
│       ├── yazi.nix         # Navegador de archivos
│       ├── zathura.nix      # Visor de PDF
│       └── zsh.nix          # Shell Zsh
├── hosts/
│   └── fs0ciety/
│       ├── configuration.nix # Configuración de NixOS
│       ├── hardware-configuration.nix
│       └── local-packages.nix
└── nixos/
    └── modules/             # Módulos del sistema NixOS
        ├── audio.nix
        ├── bluetooth.nix
        ├── boot.nix
        ├── default.nix
        ├── env.nix
        ├── home-manager.nix
        ├── hyprland.nix
        ├── kernel.nix
        ├── mime.nix
        ├── net.nix
        ├── nh.nix
        ├── nix.nix
        ├── timezone.nix
        ├── user.nix
        └── zram.nix
```

## 🚀 Instalación

### Requisitos Previos

- NixOS con flakes habilitado
- Home Manager

### Aplicar la Configuración

```bash
# Entrar al directorio del flake
cd ~/Code/nix/nixdots

# Rebuild del sistema completo
sudo nixos-rebuild switch --flake .#fs0ciety

# Solo home-manager (sin reboot)
home-manager switch --flake .#th3g3ntl3man

# Actualizar flake inputs
nix flake update
```

## 📦 Paquetes Instalados

### Aplicaciones de Escritorio
| Paquete | Descripción |
|---------|-------------|
| `anki` | Repaso espaciado de tarjetas |
| `firefox` | Navegador web |
| `mpv` | Reproductor de video |
| `obsidian` | Notas personales |
| `orca-slicer` | Slice para impresoras 3D |
| `telegram-desktop` | Mensajería |
| `qbittorrent` | Cliente BitTorrent |

### Utilidades CLI
| Paquete | Descripción |
|---------|-------------|
| `alacritty` | Terminal GPU-accelerated |
| `bat` | `cat` con sintaxis |
| `delta` | Diff viewer con colores |
| `eza` | Reemplazo moderno de `ls` |
| `fastfetch` | Info del sistema |
| `fzf` | Buscador fuzzy |
| `lazygit` | UI de Git |
| `neovim` | Editor de texto |
| `starship` | Prompt personalizado |
| `tmux` | Multiplexor de terminal |
| `yazi` | Navegador de archivos |
| `zoxide` | `cd` inteligente |
| `zsh` | Shell Zsh |

### Herramientas de Desarrollo
| Paquete | Descripción |
|---------|-------------|
| `nodejs` | Runtime de JavaScript |
| `openjdk23` | JDK de Java |
| `platformio-core` | Desarrollo embebido |
| `pnpm` | Gestor de paquetes npm |
| `python311` | Python |

## ⚙️ Módulos de Configuración

### [zsh.nix](home-manager/modules/zsh.nix)

Configuración completa de Zsh con:
- **Aliases**: Navegación, git, docker, python (uv)
- **Integraciones**: Starship, zoxide, fzf-tab
- **Historial**: 20000 entradas, ignore duplicates
- **Teclado**: Estilo Emacs con vim motions
- **OSC7/133**: Soporte para foot terminal

```nix
# Aliases destacados
gs = "git status"
l = "eza -lh --icons"
mx = "tmux"
pvc = "uv venv"
```

### [tmux.nix](home-manager/modules/tmux.nix)

Multiplexor de terminal con:
- **Tema**: Catppuccin Mocha
- **Plugins**: vim-tmux-navigator, yank, battery, cpu
- **Navegación**: Vim-style con Alt+arrows
- **Prefix**: `Alt+a`

### [git.nix](home-manager/modules/git.nix)

Configuración de Git:
- **Usuario**: Jose Vega <josevega234@gmail.com>
- **Pager**: Delta con tema oscuro
- **LFS**: Configurado para Git Large File Storage
- **Credenciales**: Helper de GitHub CLI

### [hyprland/](home-manager/modules/hyprland/)

Gestor de ventanas Wayland:

| Archivo | Descripción |
|---------|-------------|
| `main.nix` | Configuración general, workspaces, window rules |
| `binds.nix` | Atajos de teclado |
| `hypridle.nix` | Suspensión automática |
| `hyprlock.nix` | Pantalla de bloqueo |
| `hyprpaper.nix` | Gestión de papel tapiz |

**Atajos Principales:**
| Atajo | Acción |
|-------|--------|
| `Super+Return` | Abrir terminal |
| `Super+D` | Menú de aplicaciones (wofi) |
| `Super+L` | Bloquear pantalla |
| `Super+Shift+F` | Pantalla completa |
| `Super+W` | Abrir libros |
| `Print` | Captura de pantalla (área) |

### [gtk.nix](home-manager/modules/gtk.nix)

Temas GTK:
- **Tema**: Breeze-Dark
- **Iconos**: breeze-dark
- **Cursor**: capitaine-cursors
- **GTK2/GTK3**: Configurado

### [qt.nix](home-manager/modules/qt.nix)

Temas Qt5/Qt6:
- **Plataforma**: qt5ct
- **Estilo**: Breeze-Dark
- **Kvantum**: Tema alternativo
- **Font**: Noto Sans 10

### [waybar/](home-manager/modules/waybar/)

Barra de estado para Wayland:
- **Posición**: Arriba
- **Módulos**: Workspaces, ventana, audio, batería, reloj
- **Tema**: CSS personalizado
- **Scripts**: Clima (wttr.in)

### [dunst.nix](home-manager/modules/dunst.nix)

Demonio de notificaciones:
- **Tema**: Catppuccin Mocha
- **Colores**: Azul para normal, rojo para crítico
- **Fuentes**: JetBrains Mono

## 🎨 Temas y Colores

### Catppuccin Mocha (Principal)

```
bg:     #1e1e28
fg:     #dadae8
blue:   #89b4fa
pink:   #cba6f7
green:  #a6e3a1
yellow: #f9e2af
red:    #f38ba8
```

### Aplicaciones con Tema

| Aplicación | Tema |
|------------|------|
| Terminal (tmux) | Catppuccin Mocha |
| Bat | Catppuccin Macchiato |
| Waybar | CSS personalizado |
| Dunst | Catppuccin |
| GTK | Breeze-Dark |
| Qt | Breeze-Dark |

## 🔧 Personalización

### Agregar Nuevos Paquetes

Editar `home-manager/home-packages.nix`:

```nix
home.packages = with pkgs; [
  # ... paquetes existentes
  nouveau-paquete
];
```

### Agregar Nuevos Módulos

1. Crear el archivo en `home-manager/modules/`
2. Importar en `home-manager/modules/default.nix`

```nix
# home-manager/modules/default.nix
{
  imports = [
    # ... módulos existentes
    ./mi-modulo.nix
  ];
}
```

### Personalizar Hyprland

Los atajos de teclado están en `home-manager/modules/hyprland/binds.nix`.

Variables disponibles:
- `$mainMod` = SUPER
- `$terminal` = alacritty
- `$menu` = wofi

## 📝 Notas de Migración desde Dotfiles

### Archivos Migrados

| Dotfile Original | Módulo Nix Equivalent |
|-----------------|----------------------|
| `.zshrc` | `zsh.nix` |
| `.zshalias` | `zsh.nix` (shellAliases) |
| `.tmux.conf` | `tmux.nix` |
| `.gitconfig` | `git.nix` |
| `.config/fastfetch/*` | `fastfetch/` |
| `.wezterm.lua` | `wezterm/config.lua` |
| `.ideavimrc` | `ideavim.nix` |

### Archivos que Permanecen Externos

Algunos archivos pueden mantenerse fuera de Nix por preferencia personal:
- Configuraciones muy específicas de IDE
- Scripts personales complejos
- Certificates/keys

## 🔍 Solución de Problemas

### Error: "attribute 'pkgs' missing"

Verificar que `home.nix` pase `pkgs` a los módulos:

```nix
# home-manager/home.nix
{ pkgs, ... }: {
  imports = [ ./modules ];
  # ...
}
```

### Error: Flake Input No Encontrado

Actualizar los inputs del flake:

```bash
nix flake update
```

### Rebuild Lento

Usar cachés binarias:

```nix
# En configuration.nix
nix.settings.substituters = [
  "https://nix-community.cachix.org"
];
nix.settings.trusted-public-keys = [
  "nix-community.cachix.org-1:mB9FSh9qf2dCjDSj5NY7ZKyNNwcfRLy47HeU1qstmwY="
];
```

## 📚 Recursos

- [Home Manager](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Options](https://search.nixos.org/options)
- [Catppuccin](https://github.com/catppuccin/catppuccin)

## 🤝 Contribuir

1. Fork del repositorio
2. Crear branch: `git checkout -b feature/nueva-config`
3. Commit: `git commit -am 'Agregar nueva config'`
4. Push: `git push origin feature/nueva-config`
5. Crear Pull Request

---

**Última actualización**: Marzo 2026
**Autor**: Jose Vega
**Email**: josevega234@gmail.com
