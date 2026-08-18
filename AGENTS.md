# nixdots — NixOS flake configuration

Personal NixOS flake managing 4 hosts for user `th3g3ntl3man`.

## Architecture

Uses `flake-parts` with composable NixOS modules (`nixosModules`) and
`nix-wrapper-modules` for portable wrapped programs via `self'.packages`.

Each host has its own directory under `nixos/hosts/` with a `configuration.nix`
that defines both `flake.nixosModules` and `flake.nixosConfigurations`. The
`hostBase` module wires home-manager, NUR overlay, and disko automatically.

## Hosts

| Host | Features | Role |
|------|----------|------|
| `razer-blade` | general, desktop, thunar, 1password, gnome, hyprland | Desktop/laptop (full) |
| `minis-z83` | general, xfce | Server (minimal) |
| `surface-pro` | general, thunar, sway | Desktop (full) |
| `vm` | general, gnome, hyprland | VirtualBox test host |

## Key commands

```sh
nixos-rebuild switch --flake .#$(hostname)    # deploy
nix flake update                              # update all inputs
nix run .#<package>                           # run wrapped program
nix run .#environment                         # full shell environment
```

## Structure

```
flake.nix                              # Entrypoint: flake-parts imports
parts.nix                              # flake-parts config (wrappers)
wrappedPrograms/                       # Wrapped programs (self'.packages)
  default.nix                          # Index of all wrapped programs
  environment.nix                      # Full shell with all programs
  kitty.nix, git.nix, ...              # Simple programs (single .nix)
  alacritty/                           # Programs with config files
    default.nix                        #   wrapPackage with ./alacritty.toml
    alacritty.toml
  tealdeer/
    default.nix
    tealdeer-config.toml
  zellij/
    default.nix
    zellij-config.kdl
  zed/
    default.nix                        #   wrapPackage with LSPs
    zed-config/
      settings.json
      keymap.json
nixos/
  base/                                # Custom NixOS options
    host-base.nix                      # home-manager + NUR + disko wiring
    user.nix                           # preferences.user.name
    monitors.nix                       # preferences.monitors
    keymap.nix                         # preferences.keymap, autostart
  features/                            # Composable feature modules
    general.nix                        # User setup + nix settings
    nix.nix                            # Nix config, direnv, nix-index
    desktop.nix                        # Desktop (fonts, locales, hardware)
    gtk.nix                            # GTK theme (Catppuccin Mocha)
    pipewire.nix                       # Audio
    firefox.nix                        # Firefox
    chromium.nix                       # Chromium
    thunar.nix                         # Thunar file manager
    1password.nix                      # 1Password
    docker.nix                         # Docker
    ollama.nix                         # Ollama (ROCm)
  hosts/                               # One directory per host
    razer-blade/
      configuration.nix                #   flake.nixosModules.hostRazerBlade
      hardware-configuration.nix       #   nixos-generate-config output
      razer-blade.nix                  #   NVIDIA, TLP, OpenRazer
    minis/
      configuration.nix
      hardware-configuration.nix
    surface/
      configuration.nix
      hardware-configuration.nix
    vm/
      configuration.nix
      hardware-configuration.nix
hosts/
  disks/                               # Disko configurations
    gpt-ext4.nix                       #   Referenced by host configurations
modules/
  home/                                # Home Manager modules
    home.nix                           # Full desktop config
    minimal.nix                        # Minimal config
    common/                            # direnv, fonts, packages
    shell/                             # ssh only
    browsers/                          # Firefox
    desktop/                           # WM configs (Hyprland, Sway, GNOME)
    opencode/                          # AI coding tools
  nixos/
    desktop/                           # Desktop environment configs
      gnome/default.nix
      hyprland/default.nix
      sway/default.nix
      xfce/default.nix
      ...
```

## Conventions

- **Host composition**: each host imports `hostBase` + features via `imports = [ self.nixosModules.<name> ]`
- **Wrapped programs**: use `inputs.wrappers.lib.wrapPackage` for simple wraps
- **Complex wraps**: use `inputs.wrappers.wrapperModules.<name>.apply` (e.g. kitty)
- **Programs with configs**: group into a directory with `default.nix` + config files
- **Cross-references**: use `self'.packages.<name>` inside `perSystem` blocks
- **`result/`** is a build artifact — never track

## NixOS Features

Features are defined as `flake.nixosModules.<name>` in `nixos/features/`.
Hosts compose them in `nixos/hosts/<host>/configuration.nix`:

```nix
imports = [
  self.nixosModules.hostBase     # home-manager + NUR + disko
  self.nixosModules.base
  self.nixosModules.general
  self.nixosModules.desktop
  # ... more features
];
```

## Wrapped Programs

Programs are wrapped using `nix-wrapper-modules` and available as
`packages.x86_64-linux.<name>`:

- **Simple**: `inputs.wrappers.lib.wrapPackage { ... }` → single `.nix` file
- **With config**: directory with `default.nix` + config files
- **Module-based**: `inputs.wrappers.wrapperModules.<name>.apply { ... }`
- **Environment**: `self'.packages.environment` aggregates all programs

## Flake inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` | nixos-unstable |
| `home-manager` | User environment management |
| `flake-parts` | Flake structure |
| `wrappers` | Lassulus wrappers |
| `wrapper-modules` | BirdeeHub nix-wrapper-modules |
| `disko` | Declarative disk partitioning |
| `stylix` | System theming |
| `nixvim` | Neovim configuration |
| `noctalia` | Desktop shell |
| `nur` | Nix User Repository |
| `nix-index-database` | Pre-built nix-index database |
| `llm-agents` | AI coding agents (opencode, etc.) |
| `hardware` | NixOS hardware quirks |
| `razerdaemon` | Razer device control |

## OpenCode

The `opencode/` module configures OpenCode editor tooling (LSP, permissions, oh-my-opencode). The `opencode` binary comes from the `llm-agents` flake input (numtide/llm-agents.nix, daily builds), pinned via `programs.opencode.package`.
