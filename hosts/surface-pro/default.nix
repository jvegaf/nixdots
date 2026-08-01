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

  networking.hostName = "surface-pro";

  # home-manager modules
  home-manager.users.${user}.config = {

    home.packages = with pkgs; [
      moonlight-qt
      parsec-bin
    ];

    ## HOME MANAGER
    modules = {
      desktop = {
        bar = "waybar";
      };

      theme = {
        wallpaper = ../../modules/home/th3g3ntl3man/theming/wallpaper2.png;
        stylix.enable = false;
      };

      # services.nextcloud-client.enable = false;

      programs = {
        zathura.enable = true;
        rofi.enable = true;
        firefox.enable = true;
      };
    };
  };

  services = {
    fprintd = {
      enable = true; # run sudo fprintd-enroll
    };

    power-profiles-daemon.enable = true;

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
      sound.enable = true;

      bluetooth.enable = true;
      printing.enable = true;
    };

    display = {
      gpuAcceleration.enable = true;
      desktop.niri.enable = false;
      desktop.hyprland.enable = true;

      monitors = [
        {
          name = "DP-2";
          resolution = "1280x800";
          position = "auto";
          refreshRate = 60;
          scale = "1";
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
