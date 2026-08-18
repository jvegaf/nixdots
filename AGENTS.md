# nixdots — NixOS flake configuration

Personal NixOS flake managing 4 hosts for user `th3g3ntl3man`.

## Architecture

Uses `flake-parts` with composable NixOS modules (`nixosModules`) and
`nix-wrapper-modules` for portable wrapped programs via `self'.packages`.

## Hosts

| Host | Features | Home config | Role |
|------|----------|-------------|------|
| `razer-blade` | general, desktop, thunar, 1password, gnome, hyprland | `home.nix` | Desktop/laptop (full) |
| `minis-z83` | general, xfce | `minimal.nix` | Server (minimal) |
| `surface-pro` | general, thunar, sway | `sway.nix` | Desktop (full) |
| `vm` | general, gnome, hyprland | `home.nix` | VirtualBox test host |

## Key commands

```sh
nixos-rebuild switch --flake .#$(hostname)    # deploy
nix flake update                              # update all inputs
nix run .#<package>                           # run wrapped program
nix run .#environment                         # full shell environment
```

## Structure

```
flake.nix                          # Entrypoint: flake-parts + mkHost
parts.nix                          # flake-parts config (wrappers)
wrappedPrograms/                   # Wrapped programs (self'.packages)
  default.nix                      # Index of all wrapped programs
  environment.nix                  # Full shell with all programs
  kitty.nix, git.nix, ...          # Individual wrapped programs
nixos/
  base/                            # Custom NixOS options
    user.nix                       # preferences.user.name
    monitors.nix                   # preferences.monitors
    keymap.nix                     # preferences.keymap, autostart
  features/                        # Composable feature modules
    general.nix                    # User setup + nix settings
    nix.nix                        # Nix config, direnv, nix-index
    desktop.nix                    # Desktop (fonts, locales, hardware)
    gtk.nix                        # GTK theme (Catppuccin Mocha)
    pipewire.nix                   # Audio
    firefox.nix                    # Firefox
    chromium.nix                   # Chromium
    thunar.nix                     # Thunar file manager
    1password.nix                  # 1Password
    docker.nix                     # Docker
    ollama.nix                     # Ollama (ROCm)
  hosts/                           # Host modules (compose features)
    razer-blade.nix
    minis.nix
    surface.nix
    vm.nix
  legacy/                          # Old modules (commented imports)
    desktop/                       # Desktop environments (GNOME, Hyprland, etc.)
    os/                            # OS-level configs
    programs/                      # System programs
    hardware/                      # Hardware configs
modules/home/                      # Home Manager modules
  home.nix                         # Full desktop config
  minimal.nix                      # Minimal config
  common/                          # direnv, fonts, packages
  shell/                           # ssh only
  browsers/                        # Firefox
  desktop/                         # WM configs (Hyprland, Sway, GNOME)
  opencode/                        # AI coding tools
```

## Conventions

- **Feature composition**: hosts compose features via `imports = [ self.nixosModules.<name> ]`
- **Wrapped programs**: use `inputs.wrappers.lib.wrapPackage` for simple wraps
- **Complex wraps**: use `inputs.wrappers.wrapperModules.<name>.apply` (e.g. kitty)
- **Cross-references**: use `self'.packages.<name>` inside `perSystem` blocks
- **Comment-out patterns**: never delete disabled modules, toggle with `#`
- **`result/`** is a build artifact — never track

## NixOS Features

Features are defined as `flake.nixosModules.<name>` in `nixos/features/`.
Hosts compose them in `nixos/hosts/<host>.nix`:

```nix
imports = [
  inputs.self.nixosModules.base
  inputs.self.nixosModules.general
  inputs.self.nixosModules.desktop
  # ... more features
];
```

## Wrapped Programs

Programs are wrapped using `nix-wrapper-modules` and available as
`packages.x86_64-linux.<name>`:

- **Simple**: `inputs.wrappers.lib.wrapPackage { ... }`
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
