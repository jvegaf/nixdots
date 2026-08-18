# nixdots

Personal NixOS configuration for 4 hosts using `flake-parts`,
`nix-wrapper-modules`, and declarative disk management with `disko`.

## Hosts

| Host | Desktop | Disk | Notes |
|------|---------|------|-------|
| `razer-blade` | GNOME + Hyprland | `/dev/nvme0n1` | Full desktop |
| `minis-z83` | XFCE | `/dev/sda` | Minimal server |
| `surface-pro` | Sway | `/dev/nvme0n1` | Touch + pen |
| `vm` | GNOME + Hyprland | `/dev/sda` | VirtualBox test |

## Prerequisites

- NixOS ISO (Graphical or Minimal)
- Internet connection
- Target disk (empty — will be wiped)

## Fresh Install

### 1. Boot NixOS ISO

Boot from the NixOS installation media. Set up networking:

```bash
sudo iwctl                          # connect to WiFi (if needed)
ping google.com                     # verify connectivity
```

### 2. Clone the repository

```bash
sudo mkdir -p /mnt/etc/nixos
sudo git clone https://github.com/user/nixdots.git /mnt/etc/nixos
cd /mnt/etc/nixos
sudo git checkout feat/wrapper-modules
```

### 3. Partition and format with disko

Disko will partition, format, and mount your disk automatically.

**Identify your target disk:**

```bash
lsblk                               # find your disk (e.g. /dev/nvme0n1)
```

**Run disko for your host:**

```bash
# For razer-blade (NVMe):
sudo nix run github:nix-community/disko -- --mode disko \
  --flake .#razer-blade

# For minis-z83 (SATA, with 4G swap):
sudo nix run github:nix-community/disko -- --mode disko \
  --flake .#minis-z83

# For surface-pro (NVMe, with 4G swap):
sudo nix run github:nix-community/disko -- --mode disko \
  --flake .#surface-pro

# For vm (SATA):
sudo nix run github:nix-community/disko -- --mode disko \
  --flake .#vm
```

This creates:
- **ESP** (512M, vfat) → `/boot`
- **Root** (ext4) → `/`
- **Swap** (optional, specified in host config)

### 4. Generate hardware configuration

```bash
sudo nixos-generate-config --root /mnt
```

Copy the generated hardware configuration to the host directory:

```bash
# For razer-blade:
sudo cp /mnt/etc/nixos/hardware-configuration.nix \
  /mnt/etc/nixos/hosts/razer-blade/hardware-configuration.nix

# Repeat for your host
```

### 5. Install NixOS

```bash
sudo nixos-install --flake .#razer-blade
```

Replace `razer-blade` with your hostname.

### 6. Reboot and configure

```bash
sudo reboot
```

After first boot, set password and verify:

```bash
passwd th3g3ntl3man
nixos-rebuild switch --flake .#$(hostname)
```

## Deploying Changes

After the initial install, deploy changes with:

```bash
nixos-rebuild switch --flake .#$(hostname)
```

Or using the Justfile (if available):

```bash
just deploy         # nixos-rebuild switch
just up             # nix flake update
just clean          # wipe profiles older than 7d
```

## Wrapped Programs

All wrapped programs are available as `nix run` commands:

```bash
nix run .#kitty              # Terminal with Catppuccin Mocha
nix run .#git                # Git with custom env vars
nix run .#lazygit            # Lazygit with YAML config
nix run .#zsh                # Zsh with plugins
nix run .#zed                # Zed with vim keymaps + LSPs
nix run .#helix              # Evil-helix with LSPs
nix run .#bat                # Bat with Catppuccin theme
nix run .#eza                # Eza with icons + git
nix run .#btop               # System monitor
nix run .#tmux               # Tmux with custom config
nix run .#zellij             # Zellij with custom layout
nix run .#yazi               # Yazi with plugins
nix run .#starship           # Starship prompt
nix run .#nh                 # Nix helper
nix run .#fastfetch          # System info
nix run .#tealdeer           # Tldr client
nix run .#alacritty          # Alacritty terminal
nix run .#ghostty            # Ghostty terminal
nix run .#ns                 # Nix search TV
nix run .#environment        # Full shell with all programs
```

## Adding a New Host

1. Create `nixos/hosts/<name>.nix`:

```nix
{inputs, ...}: {
  flake.nixosModules.host<Name> = {pkgs, ...}: {
    imports = [
      inputs.self.nixosModules.base
      inputs.self.nixosModules.general
      inputs.self.nixosModules.desktop
      # ... more features
    ];

    networking.hostName = "<name>";
    system.stateVersion = "26.05";
  };
}
```

2. Add to `flake.nix`:

```nix
./nixos/hosts/<name>.nix  # in imports list

# and in nixosConfigurations:
<name> = mkHost {
  hostModule = inputs.self.nixosModules.host<Name>;
  extraModules = [ inputs.disko.nixosModules.disko ];
};
```

3. Create disko config if needed (see `hosts/disks/gpt-ext4.nix`).

## Adding a Wrapped Program

Create `wrappedPrograms/<name>.nix`:

```nix
{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.<name> = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.<name>;
      # flags = { "--flag" = "value"; };
      # env = { MY_VAR = "value"; };
      # runtimeInputs = [ pkgs.some-tool ];
    };
  };
}
```

Add to `wrappedPrograms/default.nix` imports:

```nix
./<name>.nix
```

Reference from other packages using `self'.packages.<name>`.

## Flake Inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` | nixos-unstable |
| `home-manager` | User environment |
| `flake-parts` | Flake structure |
| `wrapper-modules` | BirdeeHub nix-wrapper-modules |
| `wrappers` | Lassulus wrappers |
| `disko` | Declarative disk partitioning |
| `stylix` | System theming |
| `nixvim` | Neovim configuration |
| `noctalia` | Desktop shell |
| `nur` | Nix User Repository |
| `nix-index-database` | Pre-built nix-index |
| `llm-agents` | AI coding agents |
| `hardware` | NixOS hardware quirks |

## Directory Structure

```
flake.nix
wrappedPrograms/          # Wrapped programs (nix run .#<name>)
  default.nix
  environment.nix         # Full shell environment
  kitty.nix, git.nix, ...
nixos/
  base/                   # Custom NixOS options
  features/               # Composable feature modules
  hosts/                  # Host-specific configs
modules/
  home/                   # Home Manager modules
    home.nix              # Full desktop
    minimal.nix           # Minimal/server
    common/               # direnv, fonts, packages
    shell/                # ssh
    browsers/             # Firefox
    desktop/              # WM configs
    opencode/             # AI tools
```

## License

Personal configuration — not intended for redistribution.
