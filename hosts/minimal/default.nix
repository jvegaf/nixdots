{
  pkgs,
  config,
  inputs,
  ...
}:
let
  user = config.modules.os.mainUser;
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    (import ../disks/lvm-btrfs.nix { disks = [ "/dev/nvme1n1" ]; })
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "minimal";

  modules = {
    hardware = {
      cpu.type = "intel";
      # gpu.type = "nvidia";
      sound.enable = true;
    };

    os = {
      mainUser = "th3g3ntl3man";
      # autoLogin = true;
    };

    boot = {
      enableKernelTweaks = true;
      impermanence.enable = true;
    };
  };

  hardware = {
    # Udev rules for vial
    keyboard.qmk.enable = true;
  };
}
