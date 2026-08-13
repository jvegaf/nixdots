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
    inputs.razerdaemon.nixosModules.default
    (import ../disks/lvm-btrfs.nix { disks = [ "/dev/nvme0n1" ]; })
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # For niri
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  networking.hostName = "razer-blade";

  # home-manager modules
  home-manager.users.${user}.config = {

    home.packages = with pkgs; [
      moonlight-qt
      parsec-bin
    ];

    ## HOME MANAGER
    modules = {
      desktop = {
        bar = "dankMaterialShell";
      };

      theme = {
        wallpaper = ../../modules/home/th3g3ntl3man/theming/wallpaper2.png;
        stylix.enable = false;
      };

      # services.nextcloud-client.enable = false;

      programs = {
        zathura.enable = true;
        rofi.enable = true;
      };
    };
  };

  services = {
    # fprintd = {
    #   enable = true; # run sudo fprintd-enroll
    # };

    power-profiles-daemon.enable = false;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        # AIDEV-NOTE: Configuración optimizada para RTX 3070
        # Batería
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersafe";
        CPU_SCALING_MIN_FREQ_ON_BAT = "400000";
        CPU_SCALING_MAX_FRED_ON_BAT = "2400000";

        # Cargador
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        # NVIDIA
        NVIDIA_POWER_PROFILE_ON_AC = "performance";
        NVIDIA_POWER_PROFILE_ON_BAT = "auto"; # Modo dinámico

        # PCIe
        PCI_D3_ON_AC = "y";
        PCI_D3_ON_BAT = "y";

        # SATA
        SATA_ALPM_ON_BAT = "min_power";
      };
    };
    razer-laptop-control.enable = true;

    fwupd.enable = true;

    libinput = {
      enable = true;

      # disable mouse acceleration (yes im gamer)
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
        middleEmulation = false;
      };

      # touchpad settings
      touchpad = {
        naturalScrolling = true;
        tapping = true;
        clickMethod = "clickfinger";
        disableWhileTyping = true;
      };
    };
  };

  # Governor de CPU
  powerManagement.cpuFreqGovernor = "schedutil";
  ## NIXOS
  modules = {
    roles = {
      laptop.enable = true;
    };

    # networking = {
    #   tailscale.enable = false;
    #   optomizeTcp = false;
    # };

    hardware = {
      cpu.type = "intel";
      gpu.type = "hybrid-nv";
      sound.enable = true;

      bluetooth.enable = true;
      printing.enable = false;
    };

    display = {
      gpuAcceleration.enable = true;
      desktop.sway.enable = true;

      monitors = [
        {
          name = "eDP-1";
          resolution = "2580x1440";
          position = "auto";
          refreshRate = 60;
          scale = "1.50";
          primary = true;
          workspaces = [
            1
            2
            3
            4
            5
            6
            7
            8
            9
          ];
        }
      ];
    };

    programs = {
      thunar.enable = true;
    };

    os = {
      mainUser = "th3g3ntl3man";
      autoLogin = true;
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
