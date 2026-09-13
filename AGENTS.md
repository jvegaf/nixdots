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


## <samp>INSTALLATION (NixOS)</samp>

- Download the current NixOS minimal ISO from the unstable channel.

```bash
wget -O nixos-minimal.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso
```

- Boot Into the Installer.

- Format Partitions with Disko:

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:jvegaf/nixdots#hostname
```

- Install Dotfiles Using Flake

```bash
sudo nixos-install --flake github:jvegaf/nixdots#hostname --no-write-lock-file
```

- Reboot

## Updating and validating

Update flake inputs and review the resulting lock-file change:

```bash
just update
```

The repository also opens a weekly `flake.lock` update pull request through
GitHub Actions. Review that pull request before merging it.

Run the checks before switching a host:

```bash
nix flake check --all-systems
nix build .#nixosConfigurations.<host>.config.system.build.toplevel
```

Compare a host's active generation with a freshly built configuration:

```bash
just diff <host>
```

Deploy a host remotely over the configured SSH port:

```bash
just rebuild-deploy <host>
```

Test a configuration without making it the default boot entry:

```bash
sudo nixos-rebuild test --flake .#<host>
```

If a switch needs to be reverted, select an earlier generation from the boot
menu or run `sudo nixos-rebuild switch --rollback`.
