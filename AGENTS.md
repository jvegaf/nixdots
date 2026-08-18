# nixdots — NixOS flake configuration

Personal NixOS flake managing 4 hosts for user `th3g3ntl3man`.

## Architecture

Uses `flake-parts` with composable NixOS modules (`nixosModules`) and
`nix-wrapper-modules` for portable wrapped programs via `self'.packages`.

Each host has its own directory under `nixos/hosts/` with a `configuration.nix`
that defines both `flake.nixosModules` and `flake.nixosConfigurations`. The
`hostBase` module wires NUR overlay and disko automatically.

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
  wrappers.nix                         # wrapperModules: kitty, niri, which-key
  environment.nix                      # Full shell with all programs
  neovim/                              # wrapper-modules neovim
    neovim.nix                         #   wrapper with inline LSP configs
    lua/                               #   Lua config files
    after/ftplugin/                    #   Filetype overrides
    colors/                            #   Custom colorscheme
    queries/                           #   Treesitter queries
  noctalia/                            # wrapper-modules noctalia-shell
    default.nix
  yazi.nix                             # wrapper-modules yazi (plugins: gvfs, chmod)
  git.nix, lazygit.nix, ...            # Simple programs (single .nix)
  alacritty/                           # Programs with config files
    default.nix
    alacritty.toml
  tealdeer/
    default.nix
    tealdeer-config.toml
  zellij/
    default.nix
    zellij-config.kdl
  zed/
    default.nix
    zed-config/
      settings.json
      keymap.json
nixos/
  base/                                # Custom NixOS options
    host-base.nix                      # NUR + disko wiring
    user.nix                           # preferences.user.name
    monitors.nix                       # preferences.monitors
    keymap.nix                         # preferences.keymap, autostart
  features/                            # Composable feature modules
    general.nix                        # User setup + nix settings
    nix.nix                            # Nix config, direnv, nix-index
    desktop.nix                        # Desktop (fonts, locales, niri)
    gtk.nix                            # GTK theme (Catppuccin Mocha)
    pipewire.nix                       # Audio
    firefox.nix                        # Firefox
    chromium.nix                       # Chromium
    thunar.nix                         # Thunar file manager
    1password.nix                      # 1Password
    docker.nix                         # Docker
    ollama.nix                         # Ollama (ROCm)
    wallpaper/                         # Gruvbox wallpaper
      wallpaper.nix
      gruvbox-mountain-village.png
  hosts/                               # One directory per host
    razer-blade/
      configuration.nix
      hardware-configuration.nix
      razer-blade.nix                  # NVIDIA, TLP, OpenRazer
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
    gpt-ext4.nix
```

## Conventions

- **Host composition**: each host imports `hostBase` + features via `imports = [ self.nixosModules.<name> ]`
- **Wrapped programs (wrapper-modules)**: use `inputs.wrapper-modules.wrappers.<name>.wrap` for rich programs with settings
- **Wrapped programs (Lassulus)**: use `inputs.wrappers.lib.wrapPackage` for simple wraps
- **Complex wraps**: use `flake.wrappersModules.<name>` + `inputs.wrappers.wrapperModules.<name>.apply` (kitty, niri, which-key)
- **Programs with configs**: group into a directory with `default.nix` + config files
- **Cross-references**: use `self'.packages.<name>` inside `perSystem` blocks
- **All `flake.wrappersModules` definitions** must be in a single file (`wrappers.nix`) to avoid merge conflicts
- **Gruvbox theme**: hardcoded colors where joyer_nc used `self.theme.*`

## NixOS Features

Features are defined as `flake.nixosModules.<name>` in `nixos/features/`.
Hosts compose them in `nixos/hosts/<host>/configuration.nix`:

```nix
imports = [
  self.nixosModules.hostBase     # NUR + disko
  self.nixosModules.base
  self.nixosModules.general
  self.nixosModules.desktop
  # ... more features
];
```

## Wrapped Programs

Programs are wrapped using `nix-wrapper-modules` and available as
`packages.x86_64-linux.<name>`:

| Program | Wrapper | Notes |
|---------|---------|-------|
| `neovim` | `wrapper-modules.wrappers.neovim.wrap` | Inline LSP configs, lua config dir |
| `kitty` | `wrappers.wrapperModules.kitty.apply` | Catppuccin Mocha theme |
| `niri` | `wrapper-modules.wrappers.niri.wrap` | wlr-which-key menu, gruvbox colors |
| `noctalia-shell` | `wrapper-modules.wrappers.noctalia-shell.wrap` | Desktop shell |
| `yazi` | `wrapper-modules.wrappers.yazi.wrap` | Plugins: gvfs, chmod |
| `alacritty` | `wrappers.lib.wrapPackage` | Config file |
| `zed` | `wrappers.lib.wrapPackage` | vim keymaps + LSPs |
| `helix` | `wrappers.lib.wrapPackage` | Evil-helix |
| `git` | `wrappers.lib.wrapPackage` | Custom env vars |
| `lazygit` | `wrappers.lib.wrapPackage` | YAML config |
| `zsh` | `wrappers.lib.wrapPackage` | Plugins |
| `starship` | `wrappers.lib.wrapPackage` | Prompt |
| `bat` | `wrappers.lib.wrapPackage` | Catppuccin theme |
| `eza` | `wrappers.lib.wrapPackage` | Icons + git |
| `btop` | `wrappers.lib.wrapPackage` | System monitor |
| `tmux` | `wrappers.lib.wrapPackage` | Custom config |
| `zellij` | `wrappers.lib.wrapPackage` | Custom layout |
| `nh` | `wrappers.lib.wrapPackage` | Nix helper |
| `fastfetch` | `wrappers.lib.wrapPackage` | System info |
| `tealdeer` | `wrappers.lib.wrapPackage` | Tldr client |
| `ghostty` | `wrappers.lib.wrapPackage` | Terminal |
| `ns` | `wrappers.lib.wrapPackage` | Nix search TV |
| `environment` | `wrappers.lib.wrapPackage` | Full shell aggregator |

## Flake inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` | nixos-unstable |
| `flake-parts` | Flake structure |
| `wrappers` | Lassulus wrappers |
| `wrapper-modules` | BirdeeHub nix-wrapper-modules |
| `disko` | Declarative disk partitioning |
| `stylix` | System theming |
| `nur` | Nix User Repository |
| `nix-index-database` | Pre-built nix-index database |
| `llm-agents` | AI coding agents (opencode, etc.) |
| `hardware` | NixOS hardware quirks |
| `razerdaemon` | Razer device control |

## OpenCode

The `opencode/` module configures OpenCode editor tooling (LSP, permissions, oh-my-opencode). The `opencode` binary comes from the `llm-agents` flake input (numtide/llm-agents.nix, daily builds), pinned via `programs.opencode.package`.
