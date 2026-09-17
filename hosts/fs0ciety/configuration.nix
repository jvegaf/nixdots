{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    (import ../disks/gpt-ext4.nix { device = "/dev/nvme0n1"; })
    (inputs.hardware + "/common/cpu/intel/kaby-lake")
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/services/dm/ly.nix
    ../../modules/nixos/desktop/mangowm.nix
    ../../modules/nixos/desktop/niri.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs = {
    creality-print.enable = true;
    onepassword.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      powerManagement.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
  networking.hostName = "fs0ciety";

  services = {
    # Define your hostname.
    xserver.videoDrivers = [
      # "modesetting"
      "nvidia"
    ];

    # Enable touchpad support (enabled default in most desktopManager).
  };
  environment = {
    shellAliases = {
      freb = "sudo nixos-rebuild switch --flake ~/nixdots#fs0ciety --log-format internal-json -v |& nom --json";
    };
    systemPackages = with pkgs; [
      nvtopPackages.full # Monitor de GPU

      mesa-demos # Info OpenGL (glxinfo)
      # Utilidades sistema
      lm_sensors # Sensores de temperatura
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
