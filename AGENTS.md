# nixdots — NixOS flake

Personal NixOS config (flake-parts based) for user `th3g3ntl3man`, managing hosts `razer-blade`, `surface-pro`, `minis-z83`, `minimal`.

**Currently mid-refactor.** The working tree has a large staged-but-uncommitted restructure (old `home-manager/` + `nixos/` dirs → new `modules/` + `hosts/`). The flake does NOT evaluate yet — see "Known broken state" before touching anything.

## Known broken state (verify before building)

- `inputs.nix-secrets` (private repo, lives at `~/Projects/nix-secrets`) is referenced in `modules/nixos/security/sops.nix`, `modules/nixos/networking/tailscale.nix`, `modules/home/th3g3ntl3man/services/sops.nix`, and `hosts/minis-z83/default.nix`, but is **not declared in `flake.nix`**. No host will build until it's added back as an input.
- `modules/home/default.nix:41` builds home-manager users via `genAttrs config.modules.os.users (name: ./${name})`. The default is `["spector"]`, but only `modules/home/th3g3ntl3man/` exists and hosts set `modules.os.mainUser = "th3g3ntl3man"`. Hosts must set `modules.os.users = ["th3g3ntl3man"]` (also required by the `enum` in `modules/nixos/os/user.nix`).
- `./tailscale.nix` is commented out of `modules/nixos/networking/default.nix`, yet hosts set `modules.networking.tailscale.*` → eval error.
- `hosts/*/configuration.nix` are stale leftovers from the old layout, NOT imported (per-host config is `hosts/<host>/default.nix`). `minis-z83` is also missing a `configuration.nix`.

## Architecture

- `flake.nix` → flake-parts. `hosts/profiles.nix` defines all `nixosConfigurations`; every host imports `../modules/nixos` (system modules) + `../modules/home` (home-manager wiring).
- Per-host config = `hosts/<host>/default.nix`: imports `hardware-configuration.nix` (generated), disko module, and `(import ../disks/lvm-btrfs.nix { disks = [ ... ]; })`.
- System modules declare a custom `modules.*` option namespace (`options.modules.*` in each submodule's `default.nix`) and are enabled per-host from `hosts/<host>/default.nix` (e.g. `modules.hardware.cpu.type`, `modules.display.desktop.niri.enable`, `modules.boot.impermanence.enable`).
- Home config = `modules/home/<user>/`. Per-host overrides go through `home-manager.users.<mainUser>.config.modules.*` in the host `default.nix`.
- Secrets via sops-nix: per-host `<host>.yaml` + `shared.yaml` from the private `nix-secrets` input. Host age keys derive from the SSH ed25519 host key; user age key at `~/.config/sops/age/keys.txt`.
- Disk layout (disko, `hosts/disks/lvm-btrfs.nix`): LVM-on-btrfs with `/`, `/home`, `/nix`, `/persist` subvolumes; impermanence relies on `/persist`.

## Commands

```sh
just deploy         # nixos-rebuild switch --flake .#$(hostname) --elevate=sudo
just debug          # same + --show-trace --verbose
just up             # nix flake update (all inputs)
just upp i=<input>  # nix flake update <input>
nix fmt             # treefmt: nixfmt + statix + shfmt
nix flake check     # runs pre-commit hooks
```

- Dev shell via direnv (`.envrc` = `use flake`): provides treefmt, just, pre-commit, yq-go.
- Pre-commit hooks (on `nix flake check`): actionlint, luacheck, detect-private-keys, trim-trailing-whitespace, check-case-conflicts, check-symlinks, end-of-file-fixer, treefmt. Excludes `flake.lock`, `*.age`, `*.sh`.
- Remote/new-host install: `hosts/bootstrap.sh -n <host> -d <ip> -k <key> [--impermanence]` (nixos-anywhere; generates sops age keys). Note it calls `just rekey`, which has no Justfile target yet.
- niri comes from the niri-flake binary cache (`https://niri.cachix.org`, declared in `modules/nixos/os/nix.nix` and as `NIRI_CACHE` in the Justfile for the first deploy, which runs as root/trusted). The cache is only filled by niri-flake's CI for the exact (niri-flake rev, nixpkgs rev) pair it built hourly, so keep the lock fresh (`just up`) to maximize hits; a brand-new pair may miss for up to ~1h.

## Conventions

- Toggle modules by commenting their import in the aggregate `default.nix` — don't delete them (e.g. the commented `./noctalia`, `./tailscale.nix`).
- `nixpkgs.config.allowUnfree = true` set per-host.
- `result/` is gitignored. Don't commit `.direnv/` cache (currently staged along with the refactor).
