# nixdots — NixOS flake configuration

Personal NixOS flake managing 3 hosts for user `th3g3ntl3man` (José Vega, josevega234@gmail.com).

## Hosts

| Host         | NixOS modules           | Home config         | Role         |
|-------------|------------------------|--------------------|-------------|
| `razer-blade` | `./nixos/modules`       | `home-manager/home.nix` | Desktop/laptop (full) |
| `minis-z83`   | `./nixos/modules/server.nix` | `home-manager/minimal.nix` | Server (minimal) |
| `surface-pro` | `./nixos/modules`       | `home-manager/home.nix` | Desktop (full) |

`home-manager/th3g3ntl3man.nix` is imported for **all** hosts via `lib.filesystem.listFilesRecursive` — it contains stylix, packages, and programs shared everywhere. The `minimal.nix` and `server.nix` import fewer modules.

## Key commands

```sh
just deploy         # nixos-rebuild switch --flake .#$(hostname) --elevate=sudo
just debug          # same with --show-trace --verbose
just up             # nix flake update (all inputs)
just upp i=<input>  # nix flake update <input> (single input)
just clean          # wipe profiles older than 7d
just gc             # nix-collect-garbage --delete-old
```

Deploy **requires `--elevate=sudo`** (used in Justfile). The flake auto-detects hostname — never pass `--flake` manually.

Only `x86_64-linux` supported. `allowUnfree = true` is set globally. `nixpkgs` follows `nixos-unstable`.

## Structure

```
flake.nix                              # Entrypoint: 3 nixosConfigurations
hosts/<hostname>/                      # Host-specific config + hardware scan
nixos/modules/                         # System-level NixOS modules
nixos/modules/default.nix              # Desktop module set
nixos/modules/server.nix               # Server module set (subset, commented switches)
home-manager/home.nix                  # Full desktop home-manager config
home-manager/minimal.nix               # Minimal/server home-manager config
home-manager/th3g3ntl3man.nix          # Shared user config (stylix, packages, programs)
home-manager/modules/                   # Modularized home-manager components
  browsers/  common/  desktop/  editors/
  opencode/  shell/   terminals/
```

**Comment-out patterns** are used throughout for toggling modules — never delete disabled modules, just toggle their `#` in the relevant `default.nix` or `server.nix`.

## Conventions

- **List all module imports explicitly** in `default.nix` / `server.nix` aggregate files. Individual config files are pure Nix modules.
- **Stylix theming** is configured in `th3g3ntl3man.nix` using base16 chalk dark. Desktop targets (`gtk`, `qt`, `gnome`, etc.) are `lib.mkDefault false` so they can be overridden per desktop.
- **Editors**: the active editor is `nixvim` (imported in `home-manager/modules/editors/default.nix`). Others (`nvf`, `lazyvim`, `nvfvim`) are present but commented out.
- **Neovim spell/wordlist activation** runs `DirtytalkUpdate` as a home activation hook in `nvf.nix`.
- **`result/`** is a build artifact (symlink forest into `/nix/store`). Do not track, do not touch.
- **No CI**, **no formatter**, **no linter**, **no tests** configured. `treefmt-nix` is a flake input but unused. No pre-commit hooks. No devShell.

## OpenCode

The `opencode/` module configures OpenCode editor tooling (LSP, permissions, oh-my-opencode). The `opencode` binary comes from the `llm-agents` flake input (numtide/llm-agents.nix, daily builds), pinned via `programs.opencode.package`.
