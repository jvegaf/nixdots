# Disko configuration for h4z3 (VirtualBox)
# Defines the disk layout declaratively
{ lib, pkgs, disko, ... }:

{
  imports = [ disko.nixosModules.default ];

  disko.devices = {
    disk = {
      main = {
        # AIDEV-NOTE: VirtualBox typically uses /dev/sda for SATA disks
        device = "/dev/sda";
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
