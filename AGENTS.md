# NixOS Configuration (nix-dots)

Personal NixOS + Home Manager configuration managed as a Nix flake with flake-parts.

## Quick Commands

```bash
# Deploy (requires sudo)
just deploy

# Build without activating
just build

# Update all flake inputs
just up

# Update specific input (e.g., home-manager)
just upp i=home-manager

# Format code
nix fmt

# Run pre-commit checks
pre-commit run --all-files
```

## Architecture

```
flake.nix              # Flake entry point, defines hosts
flake/                 # flake-parts: formatting, devShell, pre-commit hooks
hosts/<name>/          # Per-host NixOS config (hardware-configuration.nix, configuration.nix)
modules/nixos/         # NixOS system modules (OS, hardware, desktops, programs)
modules/home/          # Home Manager modules (user config, desktops, editors, ai-tools)
pkgs/                  # Custom packages (currently empty)
```

### Hosts

Each host has its own directory under `hosts/`. Hosts are defined in `flake.nix` via the `mkHost` helper which wires up:
- `hosts/<name>/configuration.nix` (imports system modules)
- Home Manager with user `th3g3ntl3man` (default: `modules/home/home.nix`)

Active hosts: `razer-blade`, `fs0ciety`, `minis-z83`, `surface-pro`, `vm`

### Desktop Environments

NixOS-level DE modules: `modules/nixos/desktop/{hyprland,sway,gnome,kde,niri,noctalia,xfce,budgie}/`
Home-level DE modules: `modules/home/desktop/{hyprland,hyprland_2,sway,gnome,niri,noctalia,rofi,waybar,wofi,...}/`

Hosts import specific DEs in their `configuration.nix`.

## Code Style

- **Formatter**: `nix fmt` runs treefmt with `nixfmt` (primary), `statix`, and `shfmt`
- **Pre-commit hooks**: actionlint, luacheck, detect-private-keys, trim-trailing-whitespace, check-case-conflicts, check-symlinks, end-of-file-fixer, treefmt
- **Excluded from hooks**: `flake.lock`, `*.age`, `*.sh`

## Gotchas

- `just deploy` / `nixos-rebuild switch` needs `--elevate=sudo`
- Host is auto-detected via `hostname` in the justfile
- The flake uses `flake-parts` with `perSystem` — custom packages go in `pkgs/default.nix` as `perSystem.packages`
- direnv integration: `.envrc` calls `use flake` to activate the devShell automatically
- Home Manager backup behavior: `overwriteBackup = true`, `backupFileExtension = "backup"`
