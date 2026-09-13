# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.razerdaemon.nixosModules.default
    (inputs.hardware + "/common/cpu/intel/comet-lake")
    (import ../disks/gpt-ext4.nix { device = "/dev/disk/by-id/nvme-CT500P1SSD8_2004E284F1D7"; })
    ../../modules/nixos
    ../../modules/nixos/services/dm/ly.nix
    ../../modules/nixos/desktop/gnome.nix
    ../../modules/nixos/desktop/mangowm.nix
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "razer-blade";
  programs = {
    creality-print.enable = true;
    blender.enable = false;
    onepassword.enable = true;
  };
  environment = {
    shellAliases = {
        freb = "sudo nixos-rebuild switch --flake ~/nixdots#razer-blade --log-format internal-json -v |& nom --json";
    };

    systemPackages = with pkgs; [
      nvtopPackages.full # Monitor de GPU

      brightnessctl
      smartmontools
      mesa-demos # Info OpenGL (glxinfo)
      # Utilidades sistema
      lm_sensors # Sensores de temperatura

      libva
      libva-utils
      # Utilidades Razer
      openrazer-daemon
      polychromatic

      # Utilidades sistema
      powertop # Análisis de energía
      linuxPackages.cpupower # Control CPU
    ];

    sessionVariables = {
      # Necesario para NVIDIA + Wayland
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      # AIDEV-NOTE: Para pantallas externas con NVIDIA
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware = {
    # Razer-specific utilities
    openrazer = {
      enable = true;
      users = [ "th3g3ntl3man" ]; # Adjust to your username
      syncEffectsEnabled = true;
      devicesOffOnScreensaver = true;
      batteryNotifier = {
        enable = true;
        frequency = 600;
        percentage = 33;
      };
    };
    enableRedistributableFirmware = true;
    nvidia = {
      open = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        offload.enable = false;
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # Vulkan support
        # vulkan-validation-layers dropped: debug-only layer, broken build on
        # nixpkgs 1.4.350.0 (update_deps.py git-clones in the sandbox).
        vulkan-loader
        vulkan-tools

        # Video acceleration
        libva-vdpau-driver
        nvidia-vaapi-driver

        # Intel iGPU video decode (Optimus: the Intel chip drives the panel and
        # should do video, leaving the dGPU idle). Without this there is NO
        # Intel VA-API driver in the closure at all — /run/opengl-driver/lib/dri
        # had neither iHD nor i965 — so browsers and players fell back to
        # software decode and burned battery.
        #
        # Deliberately NOT paired with LIBVA_DRIVER_NAME=nvidia: forcing VA-API
        # at the dGPU on a hybrid laptop defeats exactly this. Leave the driver
        # unset so libva picks per-device.
        intel-media-driver

        # # CUDA support
        # cudaPackages.cudatoolkit
        # cudaPackages.cudnn
      ];
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable touchpad support (enabled default in most desktopManager).
  # Consolidated services configuration
  services = {
    xserver = {
      videoDrivers = [
        # "modesetting"
        "nvidia"
      ];
    };
    razer-laptop-control.enable = true;

    # Backlight control key bindings
    actkbd = {
      enable = true;
      bindings = [
        # Add key bindings for brightness control
        {
          keys = [ 224 ];
          events = [ "key" ];
          command = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        }
        {
          keys = [ 225 ];
          events = [ "key" ];
          command = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        }
      ];
    };

    # Battery optimization
    upower = {
      criticalPowerAction = "Hibernate";
    };

    # Support for closing lid
    logind = {
      settings.Login = {
        HandleLidSwitch = lib.mkDefault "suspend";
        HandleLidSwitchExternalPower = "ignore";
      };
    };
  };

  # Fan control and thermal management for Razer
  boot.extraModprobeConfig = ''
    options i915 enable_fbc=1 enable_guc=2
  '';
  # already defines that attribute, so it cannot be assigned twice.)
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "th3g3ntl3man" ];
  # virtualisation.virtualbox.host.enableHardening = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
