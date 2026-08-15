# Building and Installing the `vm` Host

The `vm` host is a VirtualBox test machine that mirrors the razer-blade
desktop (GNOME + Hyprland Lua config + Noctalia) so desktop changes can be
validated before touching real hardware.

This document covers the full flow: installing Nix on an Arch/CachyOS host,
building the flake there, and installing the resulting system into the VM.

## Overview

```
Arch host (CachyOS)                VirtualBox VM
-----------------                  -------------
1. Install Nix (pacman)
2. Configure Nix (flakes, trust)
3. Build toplevel      ────────▶   boot NixOS ISO
   (nix build)                     4. Partition with disko
                                  5. nixos-install --system <path>
```

The build happens **on the host**, not in the VM. The VM only receives the
final closure, so no compilation happens inside the guest.

---

## 1. Install Nix on Arch (host)

Nix is in the official Arch repos, no AUR needed:

```bash
sudo pacman -S nix
sudo systemctl enable --now nix-daemon
```

### Create the `nix-users` group

The Arch package **does not create `nix-users`** (only `nixbld`, the internal
build group). Create it manually and add your user:

```bash
sudo groupadd nix-users
sudo usermod -aG nix-users $USER
```

The new group applies on your **next login**. To pick it up without
relogging: `newgrp nix-users`, or just close and reopen the terminal.

### Create the Nix store

The Arch package also **does not create `/nix/store`** — the daemon starts but
`/nix/store` is missing, so every Nix command fails with:

```
error: opening file "/nix/store": No such file or directory
```

Create the missing directories and restart the daemon:

```bash
sudo mkdir -p \
  /nix/store \
  /nix/var/nix/db \
  /nix/var/nix/profiles \
  /nix/var/nix/temproots \
  /nix/var/log/nix

sudo systemctl restart nix-daemon
```

### Enable flakes and trusted users

Write `/etc/nix/nix.conf` (this overwrites the default; the Arch default only
contains the `build-users-group` comment block, so nothing is lost):

```bash
sudo tee /etc/nix/nix.conf <<'EOF'
build-users-group = nixbld
experimental-features = nix-command flakes
trusted-users = root th3g3ntl3man
EOF
```

`trusted-users` is **required**: without it, the flake's `nixConfig`
substituters (hyprland, noctalia, numtide, nix-community cachix) are ignored
with `ignoring untrusted substituter ... you are not a trusted user`, and the
build tries to compile everything from source instead of pulling from cache.

Restart the daemon so the config applies:

```bash
sudo systemctl restart nix-daemon
```

### Verify

```bash
nix --version
nix eval --expr '1+1'        # must print 2
nix flake show ~/Code/nixdots
```

---

## 2. Build the flake (host)

```bash
cd ~/Code/nixdots

# First run after adding an input (e.g. disko): refresh the lock
nix flake lock

# Build the whole system closure for the vm host
nix build .#nixosConfigurations.vm.config.system.build.toplevel --print-out-paths
```

The command prints the store path of the finished system, for example:

```
/nix/store/ws12x4fzs61jgxmy4h0pvs4qicanzi85-nixos-system-vm-26.11.20260813.0e251e2
```

First build pulls several GB from the caches (nixpkgs + cachix). Expect
20–30 GB free disk space.

---

## 3. Install into the VM

### 3.1 Boot the VM

Boot the NixOS ISO in VirtualBox. **Enable UEFI** in the VM settings
(Settings → System → Enable EFI) or the systemd-boot install will not boot.

Connect the VM to the network (NAT with port forwarding or bridged).

### 3.2 Copy the closure from host to VM

From the host:

```bash
nix copy --to ssh://nixos@<vm-ip> \
  /nix/store/ws12x4fzs61jgxmy4h0pvs4qicanzi85-nixos-system-vm-26.11.20260813.0e251e2
```

The NixOS ISO runs `nixos` as default user; `nix copy` needs SSH access
(password or key). The closure is then available in the VM's store without
any build.

### 3.3 Partition the disk

Two options:

**With disko** (declarative, one command — the layout lives in
`hosts/vm/disko.nix`: GPT, ESP 512M vfat at `/boot`, root ext4 at `/`):

```bash
nix run github:nix-community/disko -- --mode disko --flake github:jvegaf/nixdots#vm
```

**Manually** with `fdisk`/`mkfs` (same layout):

```bash
# /dev/sda1: 512M type EFI -> mkfs.vfat, mount /mnt/boot
# /dev/sda2: rest          -> mkfs.ext4, mount /mnt
```

`--mode disko` wipes the disk completely — fine for a test VM, but double
check the device on any other machine.

### 3.4 Install without building

```bash
sudo nixos-install --root /mnt \
  --system /nix/store/ws12x4fzs61jgxmy4h0pvs4qicanzi85-nixos-system-vm-26.11.20260813.0e251e2
```

`nixos-install --system <path>` installs a **pre-built** closure: no flake
evaluation, no compilation in the VM. Then reboot and the VM boots the
systemd-boot entry.

---

## Known issues

### VirtualBox guest additions do not build (upstream bug)

`virtualbox-guest-additions 7.2.14` fails to compile against modern kernels:

```
vboxvideo/vbox_fb.c:336: error: assignment to 'struct fb_info *' from 'int'
```

The driver uses `drm_fb_helper_alloc_fbi()`, removed in favor of
`drm_fb_helper_alloc_info()`. This fails on **all** recent kernels
(6.6/6.12/6.18), so pinning an older `boot.kernelPackages` does **not** help.

Tracked upstream:

- VirtualBox issues #467, #812
- nixpkgs issue #363887

**Current state**: `virtualisation.virtualbox.guest.enable = false` in
`hosts/vm/configuration.nix`. The desktop works through the EFI framebuffer;
shared folders (`vboxsf`), clipboard and drag&drop are lost. To re-enable
once the package builds:

```nix
virtualisation.virtualbox.guest.enable = true;
users.users.th3g3ntl3man.extraGroups = [ "vboxsf" ];
```

### home-manager must use the global pkgs

`home-manager.useGlobalPkgs = true` is set in `flake.nix`. Without it,
home-manager evaluates its **own** pkgs, missing the flake's overlays
(e.g. the `gentle-ai` package), causing `undefined variable 'gentle-ai'`
during the build.

---

## Troubleshooting cheat sheet

| Symptom | Fix |
|---|---|
| `group 'nix-users' does not exist` | `sudo groupadd nix-users && sudo usermod -aG nix-users $USER` |
| `experimental Nix feature 'nix-command' is disabled` | add `experimental-features = nix-command flakes` to `/etc/nix/nix.conf` |
| `opening file "/nix/store": No such file or directory` | create the `/nix` directory structure and restart `nix-daemon` (section 1) |
| `ignoring untrusted substituter ... you are not a trusted user` | add `trusted-users = root <user>` to `/etc/nix/nix.conf` |
| `undefined variable 'gentle-ai'` (or any flake overlay) | keep `home-manager.useGlobalPkgs = true` in `flake.nix` |
| Guest additions build failure | disable `virtualisation.virtualbox.guest.enable` (known issue above) |
