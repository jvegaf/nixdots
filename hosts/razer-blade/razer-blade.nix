# AIDEV-NOTE: Razer Blade 15 Advanced 2021 (RTX 3070) specific configuration
# This module configures hybrid graphics (Intel + NVIDIA), Openrazer for RGB,
# TLP for power management, and kernel parameters specific to Razer laptops.

{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.razerdaemon.nixosModules.default ];
  ##############################
  # 🧠 BASICS
  ##############################
  nixpkgs.config.allowUnfree = true;

  # Enable systemd-boot
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Kernel moderno (recomendado para 11th gen + RTX 30xx)
  # Use linuxPackages_latest for better hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    kernelParams = [
      "nvidia-drm.modeset=1" # Required for Wayland
      "nvidia-drm.fbdev=1" # Fixes external-monitor flicker on niri: without a DRM
      "button.lid_init_state=open"
      # fbdev the NVIDIA driver drops the surface in the vblank callback on the
      # second dGPU-driven CRTC ("missing surface in vblank callback").
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Helps with suspend/resume
      "nvidia.NVreg_TemporaryFilePath=/tmp" # Fix for temp file issues
    ];

    # Early load NVIDIA modules
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
  };
  services = {
    razer-laptop-control.enable = true;
    # Fix típico de Razer: problema con el cierre de tapa
    # AIDEV-NOTE: Algunos usuarios reportan problemas con lid, ajustar si es necesario

    xserver.enable = true;
    # xserver.videoDrivers = [
    #   "nvidia"
    # ];

    # Disable power-profiles-daemon (conflicts with TLP)
    power-profiles-daemon.enable = false;

    # NVIDIA TGP Control (opcional, para limitar consumo GPU)
    # AIDEV-NOTE: Puede requerir nvidia-smi del paquete nvidia-utils
    # hardware.nvidia.powerManagement.enable = true;  # Experimental

    ##############################
    # 🔋 POWER MANAGEMENT - TLP
    # AIDEV-NOTE: TLP y auto-cpufreq no se deben usar juntos
    ##############################
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

    ##############################
    # 🌡️ THERMAL MANAGEMENT
    ##############################
    # AIDEV-NOTE: Razer Blade puede necesitar gestión térmica adicional
    # Considerar: thermald para gestión de热量
    thermald.enable = true;
  };

  # Configuración NVIDIA con PRIME sync
  hardware = {
    nvidia = {
      # modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      # nvidiaPersistenced = false;
      open = true; # NVIDIA 590+ requires open kernel modules for Turing GPUs (RTX 2070 Super)
      nvidiaSettings = true;
      # beta (595.45.04) fails to build against kernel 7.1 — it includes
      # linux/of_gpio.h, removed in 7.x. latest (610.43.02) handles the removal.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        sync.enable = true;
        # offload.enable = false;
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

    # Docker NVIDIA support
    # nvidia-container-toolkit.enable = true;
  };

  # Governor de CPU
  powerManagement.cpuFreqGovernor = "schedutil";

  ##############################
  # ⌨️ RAZER - Openrazer (RGB)
  # AIDEV-NOTE: Requiere permisos de usuario para acceder al daemon
  ##############################
  hardware.openrazer = {
    enable = true;
    # AIDEV-NOTE: enableVerbose = true para debugging si hay problemas
    # enableVerbose = false;
    # packages = with pkgs; [
    #   openrazer-daemon
    #   polychromatic # GUI para controlar RGB
    #   razercfg # Alternativa CLI
    # ];
  };

  # AIDEV-NOTE: El usuario debe estar en el grupo 'openrazer'
  users.users.th3g3ntl3man = {
    extraGroups = [ "openrazer" ];
  };

  ##############################
  # 🔥 FIREWALL
  ##############################
  networking.firewall.enable = true;

  ##############################
  # 📦 PAQUETES ADICIONALES
  ##############################
  environment.systemPackages = with pkgs; [
    # Utilidades GPU
    pciutils # lspci, etc.
    mesa-demos # Info OpenGL (glxinfo)
    nvtopPackages.nvidia # Monitor de GPU
    nvtopPackages.intel # Monitor de GPU

    libva
    libva-utils
    # Utilidades Razer
    openrazer-daemon
    polychromatic

    # Utilidades sistema
    lm_sensors # Sensores de temperatura
    powertop # Análisis de energía
    linuxPackages.cpupower # Control CPU
  ];

  ##############################
  # 🖥️ WAYLAND - Hyprland (fs0ciety usa Hyprland)
  # AIDEV-NOTE: Ya configurado en modules/hyprland.nix
  ##############################
  # El módulo hyprland ya está importado en fs0ciety/configuration.nix
  # Pero aseguramos que las dependencias de NVIDIA estén presentes para Wayland
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # AIDEV-NOTE: Para NVIDIA + Wayland, configurar variables de entorno
  environment.sessionVariables = {
    # Necesario para NVIDIA + Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    # AIDEV-NOTE: Para pantallas externas con NVIDIA
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  ##############################
  # ⚙️ STATE VERSION
  ##############################
  system.stateVersion = "26.05";
}
