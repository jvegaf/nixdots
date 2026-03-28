# Disko - Configuración Declarativa de Discos

## Overview

**Disko** es una herramienta de NixOS que permite definir la estructura del disco de forma declarativa en Nix. En lugar de particionar manualmente, definimos el layout en un archivo `.nix` y disko se encarga de crear las particiones y sistemas de archivos.

## Integración en el Proyecto

### Inputs (flake.nix)

```nix
disko = {
  url = "github:nix-community/disko";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

### Estructura del Archivo

Cada host puede tener su propio `disko.nix`:

```
hosts/
├── fs0ciety/
│   ├── disko.nix              # Configuración de disco
│   ├── configuration.nix      # Importa disko.nix
│   └── ...
├── h4z3/
│   └── ...
└── wh1t3r0s3/
    └── ...
```

## Configuración de fs0ciety

### hosts/fs0ciety/disko.nix

```nix
{ lib, pkgs, disko, ... }:

{
  imports = [ disko.nixosModules.default ];

  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              label = "BOOT";
              start = "1MiB";
              end = "512MiB";
              type = "EF00"; # EFI System Partition
              format = {
                fsType = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              label = "NIXROOT";
              start = "512MiB";
              end = "100%";
              format = {
                fsType = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
```

### hosts/h4z3/disko.nix

```nix
{ lib, pkgs, disko, ... }:

{
  imports = [ disko.nixosModules.default ];

  disko.devices = {
    disk = {
      main = {
        # VirtualBox usa /dev/sda para SATA
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              label = "BOOT";
              start = "1MiB";
              end = "512MiB";
              type = "EF00";
              format = {
                fsType = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              label = "NIXROOT";
              start = "512MiB";
              end = "100%";
              format = {
                fsType = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
```

### Comparación de Particiones

| Host | Disco | Partición | Tamaño | Tipo | FS | Mountpoint |
|------|-------|-----------|--------|------|-----|------------|
| fs0ciety | /dev/nvme0n1 | boot | 1MiB - 512MiB | EFI (EF00) | vfat | /boot |
| fs0ciety | /dev/nvme0n1 | root | 512MiB - 100% | Linux | ext4 | / |
| h4z3 | /dev/sda | boot | 1MiB - 512MiB | EFI (EF00) | vfat | /boot |
| h4z3 | /dev/sda | root | 512MiB - 100% | Linux | ext4 | / |
| wh1t3r0s3 | /dev/sda | boot | 1MiB - 512MiB | EFI (EF00) | vfat | /boot |
| wh1t3r0s3 | /dev/sda | root | 512MiB - 100% | Linux | ext4 | / |

## Comandos

### fs0ciety (NVMe)

```bash
# Formatear y instalar
sudo disko --mode format --flake .#fs0ciety

# O con nixos-install
sudo nixos-install --flake .#fs0ciety --disk /dev/nvme0n1
```

### h4z3 (VirtualBox SATA)

```bash
# Formatear y instalar
sudo disko --mode format --flake .#h4z3

# O con nixos-install
sudo nixos-install --flake .#h4z3 --disk /dev/sda
```

### wh1t3r0s3 (VMware SCSI)

```bash
# Formatear y instalar
sudo disko --mode format --flake .#wh1t3r0s3

# O con nixos-install
sudo nixos-install --flake .#wh1t3r0s3 --disk /dev/sda
```

### Solo particionar (sin instalar)

```bash
# fs0ciety
sudo disko --mode create --flake .#fs0ciety

# h4z3
sudo disko --mode create --flake .#h4z3

# wh1t3r0s3
sudo disko --mode create --flake .#wh1t3r0s3
```

### Montar particiones existentes

```bash
# fs0ciety
sudo disko --mode mount --flake .#fs0ciety

# h4z3
sudo disko --mode mount --flake .#h4z3

# wh1t3r0s3
sudo disko --mode mount --flake .#wh1t3r0s3
```

### Desmontar

```bash
# fs0ciety
sudo disko --mode umount --flake .#fs0ciety

# h4z3
sudo disko --mode umount --flake .#h4z3

# wh1t3r0s3
sudo disko --mode umount --flake .#wh1t3r0s3
```

## Opciones Comunes de Disko

### Tipos de disco

```nix
disko.devices.disk = {
  main = {
    device = "/dev/sda";  # Disco entero
    # device = "/dev/nvme0n1";  # NVMe
    type = "disk";
  };
};
```

### Tipos de particiones GPT

| Código | Tipo | Descripción |
|--------|------|-------------|
| `EF00` | EFI System Partition | Boot EFI |
| `8300` | Linux | Filesystem (default) |
| `8200` | Linux swap | Swap |
| `8301` | Linux /home | Home partition |
| `FD00` | Linux RAID | RAID |
| `LVM2` | Linux LVM | LVM |

### Sistemas de archivos

```nix
format = {
  fsType = "ext4";      # ext4, btrfs, xfs, f2fs, vfat, ntfs
  # mountpoint = "/";   # Solo si quieres que se monte automáticamente
  # label = "ROOT";     # Label opcional
  # options = ["compress=zstd" "noatime"];  # Opciones adicionales
};
```

### Ejemplo con Btrfs

```nix
root = {
  label = "NIXROOT";
  start = "512MiB";
  end = "100%";
  format = {
    fsType = "btrfs";
    mountpoint = "/";
    subvolumes = {
      "@" = {
        mountpoint = "/";
      };
      "@home" = {
        mountpoint = "/home";
      };
      "@nix" = {
        mountpoint = "/nix";
      };
      "@snapshots" = {
        mountpoint = "/.snapshots";
      };
    };
  };
};
```

### Ejemplo con Swap

```nix
partitions = {
  boot = { ... };
  swap = {
    label = "SWAP";
    start = "512MiB";
    end = "16GiB";
    format = {
      fsType = "swap";
      swap = {
        label = "SWAP";
      };
    };
  };
  root = {
    start = "16GiB";
    end = "100%";
    ...
  };
};
```

## Integración con hardware-configuration.nix

Después de usar disko, el archivo `hardware-configuration.nix` ya no necesita las definiciones de fileSystems porque disko las genera automáticamente.

### Antes (sin disko)

```nix
fileSystems."/" = {
  device = "/dev/disk/by-uuid/08d44b2d-ddc3-48f1-aa06-34d017157410";
  fsType = "ext4";
};
```

### Después (con disko)

Las particiones se definen en `disko.nix` y se generan automáticamente. El `hardware-configuration.nix` ahora solo define los módulos del kernel:

```nix
boot.kernelModules = [ "kvm-intel" ];
```

## Troubleshooting

### "device is busy"

```bash
# Desmontar primero
sudo umount /mnt /mnt/boot
sudo disko --mode umount --flake .#fs0ciety
```

### Error de permisos

```bash
# Ejecutar desde live ISO o con sudo
sudo disko --mode format --flake .#fs0ciety
```

### Particiones no se crean

```bash
# Verificar el dispositivo
ls -la /dev/nvme*
sudo fdisk -l /dev/nvme0n1
```

### Recuperar datos después de formatear

Desafortunadamente, disko **no** tiene recuperación integrada. Usar herramientas como `testdisk` o `photorec` antes de formatear.

## Referencias

- [Disko GitHub](https://github.com/nix-community/disko)
- [Disko Manual](https://github.com/nix-community/disko#readme)
- [NixOS Wiki - Disko](https://nixos.wiki/wiki/Disko)
