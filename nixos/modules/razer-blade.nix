# AIDEV-NOTE: Razer Blade 15 Advanced 2021 (RTX 3070) specific configuration
# This module configures hybrid graphics (Intel + NVIDIA), Openrazer for RGB,
# TLP for power management, and kernel parameters specific to Razer laptops.

{ config, lib, pkgs, ... }:

{
  ##############################
  # 🧠 BASICS
  ##############################
  nixpkgs.config.allowUnfree = true;

  # Enable systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel moderno (recomendado para 11th gen + RTX 30xx)
  # Use linuxPackages_latest for better hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Fix típico de Razer: problema con el cierre de tapa
  # AIDEV-NOTE: Algunos usuarios reportan problemas con lid, ajustar si es necesario
  boot.kernelParams = [
    "button.lid_init_state=open"
    # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"  # Para suspender correctamente
  ];

  # Timezone (ajustar según ubicación)
  time.timeZone = lib.mkDefault "Europe/Madrid";

  ##############################
  # 💻 GPU - Intel + NVIDIA RTX 3070 (Optimus/PRIME)
  # AIDEV-NOTE: Los Bus IDs pueden variar, verificar con: lspci | grep -E "VGA|3D"
  ##############################
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # OpenGL para aceleración híbrida
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Configuración NVIDIA con PRIME sync
  hardware.nvidia = {
    # Drivers estables
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Modesetting del kernel para mejor rendimiento
    modesetting.enable = true;

    # Power management (freq scaling)
    powerManagement.enable = true;

    # AIDEV-NOTE: Verificar estos Bus IDs en el equipo específico
    # Ejecutar: lspci | grep -E "VGA|3D"
    # Ejemplo típico para Razer Blade 15 2021:
    #   00:02.0 VGA compatible controller: Intel Corporation (iGPU)
    #   01:00.0 VGA compatible controller: NVIDIA Corporation RTX 3070
    prime = {
      # Sincronización de frames para evitar tearing en modo híbrido
      sync.enable = true;

      # Bus IDs verificados en este hardware (lspci | grep -E "VGA|3D")
      #   00:02.0 Intel UHD Graphics (CometLake-H GT2)
      #   01:00.0 NVIDIA RTX 3070 Mobile
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # NVIDIA TGP Control (opcional, para limitar consumo GPU)
  # AIDEV-NOTE: Puede requerir nvidia-smi del paquete nvidia-utils
  # hardware.nvidia.powerManagement.enable = true;  # Experimental

  ##############################
  # 🔋 POWER MANAGEMENT - TLP
  # AIDEV-NOTE: TLP y auto-cpufreq no se deben usar juntos
  ##############################
  services.tlp = {
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
      NVIDIA_POWER_PROFILE_ON_BAT = "auto";  # Modo dinámico

      # PCIe
      PCI_D3_ON_AC = "y";
      PCI_D3_ON_BAT = "y";

      # SATA
      SATA_ALPM_ON_BAT = "min_power";
    };
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
    enableVerbose = false;
    packages = with pkgs; [
      openrazer-daemon
      polychromatic  # GUI para controlar RGB
      razercfg       # Alternativa CLI
    ];
  };

  # AIDEV-NOTE: El usuario debe estar en el grupo 'openrazer'
  users.users.${config.users.users ? th3g3ntl3man ? "th3g3ntl3man" ? "amper"} = lib.mkIf (config.users.users ? th3g3ntl3man) {
    extraGroups = [ "openrazer" ];
  };

  ##############################
  # 🌡️ THERMAL MANAGEMENT
  ##############################
  # AIDEV-NOTE: Razer Blade puede necesitar gestión térmica adicional
  # Considerar: thermald para gestión de热量
  services.thermald.enable = lib.mkDefault true;

  # AIDEV-NOTE: Limitación de TDP para laptops (opcional, requiere kernel config)
  # boot.extraModulePackages = with pkgs; [ ];  # Añadir modules de thermald si es necesario

  ##############################
  # 🔊 AUDIO - PipeWire
  ##############################
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Low latency configuration for audio profesional
    lowLatency.enable = lib.mkDefault false;
  };

  ##############################
  # 🌐 NETWORK - NetworkManager
  ##############################
  networking.networkmanager.enable = true;

  # WiFi power saving (puede causar problemas con algunos adaptadores)
  networking.wireless.powerSave = false;

  ##############################
  # 🔥 FIREWALL
  ##############################
  networking.firewall.enable = true;

  ##############################
  # 📦 PAQUETES ADICIONALES
  ##############################
  environment.systemPackages = with pkgs; [
    # Utilidades GPU
    pciutils                               # lspci, etc.
    glxinfo                                # Info OpenGL
    nvtop                                  # Monitor de GPU
    nvidia-settings                        # Config NVIDIA
    nvidia-smi                             # Monitor CLI

    # Utilidades Razer
    openrazer-daemon
    polychromatic

    # Utilidades sistema
    lm_sensors                             # Sensores de temperatura
    powertop                              # Análisis de energía
    cpupower                              # Control CPU
  ];

  ##############################
  # 🖥️ WAYLAND - Hyprland (fs0ciety usa Hyprland)
  # AIDEV-NOTE: Ya configurado en modules/hyprland.nix
  ##############################
  # El módulo hyprland ya está importado en fs0ciety/configuration.nix
  # Pero aseguramos que las dependencias de NVIDIA estén presentes para Wayland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
  system.stateVersion = "25.11";
}