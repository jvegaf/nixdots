# Disko configuration for fs0ciety
# Defines the disk layout declaratively
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
              # AIDEV-NOTE: extends to end of disk (minus optional swap)
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
