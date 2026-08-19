{
  inputs,
  config,
  self,
  ...
}:
{
  flake.nixosConfigurations.razerBlade = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostRazerBlade
    ];
  };

  flake.nixosModules.hostRazerBlade =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.base
        self.nixosModules.general
        self.nixosModules.desktop

        self.nixosModules.impermanence

        self.nixosModules.telegram

        self.nixosModules.thunar
        self.nixosModules.onepassword

        # Hardware
        self.nixosModules.razerBladeHardware
        inputs.razerdaemon.nixosModules.default

        # disko
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.razerBlade
      ];

      services.razer-laptop-control.enable = true;
      nixpkgs.config.allowUnfree = true;
      networking.hostName = "razer-blade";

      boot.kernelPackages = pkgs.linuxPackages_latest;

      ##############################
      # 💻 GPU - Intel + NVIDIA RTX 3070 (Optimus/PRIME)
      # AIDEV-NOTE: Los Bus IDs pueden variar, verificar con: lspci | grep -E "VGA|3D"
      ##############################
      services.xserver.enable = true;
      services.xserver.videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # Disable power-profiles-daemon (conflicts with TLP)
      services.power-profiles-daemon.enable = true;

      # Configuración NVIDIA con PRIME sync
      hardware.nvidia = {
        # Drivers estables
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        # Use open-source kernel module
        open = true;
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
          # sync.enable = true;
          offload.enable = true;
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
        enable = false;
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

      # Governor de CPU
      # powerManagement.cpuFreqGovernor = "schedutil";

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
      # 🌡️ THERMAL MANAGEMENT
      ##############################
      # AIDEV-NOTE: Razer Blade puede necesitar gestión térmica adicional
      # Considerar: thermald para gestión de热量
      services.thermald.enable = true;

      # AIDEV-NOTE: Limitación de TDP para laptops (opcional, requiere kernel config)
      # boot.extraModulePackages = with pkgs; [ ];  # Añadir modules de thermald si es necesario

      ##############################
      # 🌐 NETWORK - NetworkManager
      ##############################
      # networking.networkmanager.enable = true;

      # WiFi power saving (puede causar problemas con algunos adaptadores)
      # networking.wireless.powerSave = false;

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

      services.udisks2.enable = true;

      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdg.portal.enable = true;

      programs.niri.enable = true;
      system.stateVersion = "26.05";
    };
}
