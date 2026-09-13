{ pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (inputs.hardware + "/common/cpu/intel/skylake")
    (import ../disks/gpt-ext4.nix {
      device = "/dev/nvme0n1";
      swapSize = "4G";
    })
    ../../modules/nixos
    ../../modules/nixos/desktop/gnome.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.shellAliases = {
      freb = "sudo nixos-rebuild switch --flake ~/nixdots#surface-pro --log-format internal-json -v |& nom --json";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "surface-pro";
  system.stateVersion = "26.05"; # Did you read the comment?

}
