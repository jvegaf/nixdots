# Disk layout for the VirtualBox test VM.
#
# Partitions, formats and mountpoints are fully declared here, so the
# disk can be set up with a single command:
#
#   nix run github:nix-community/disko -- --mode disko \
#     --flake .#vm
#
# The device is a parameter: each host passes its own disk path when
# importing this layout (e.g. `{ device = "/dev/sda"; }`).
#
# Layout: GPT with an EFI System Partition (vfat, mounted at /boot) and
# the root filesystem (ext4, mounted at /).
{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0022" "dmask=0022" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
