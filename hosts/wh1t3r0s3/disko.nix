# Disko configuration for wh1t3r0s3 (VMware Workstation)
# Defines the disk layout declaratively
{ lib, pkgs, disko, ... }:

{
  imports = [ disko.nixosModules.default ];

  disko.devices = {
    disk = {
      main = {
        # AIDEV-NOTE: VMware typically uses /dev/sda for SCSI virtual disks
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
