# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/hardware
    ../../modules/nixos/os
    ../../modules/nixos/programs
    ../../modules/nixos/desktop/gnome
  ];

  # nix.settings.experimental-features = ["nix-command" "flakes"];
  #
  # # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  #
  # # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  networking.hostName = "fs0ciety"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    # Requerido para Wayland (vital para Hyprland/Niri)
    modesetting.enable = true;

    # Gestión de energía de NVIDIA
    powerManagement.enable = true;

    # La MX150 es Pascal, por lo que requiere los drivers cerrados (open = false)
    open = false;

    # Habilita el menú de configuración de NVIDIA (nvidia-settings)
    nvidiaSettings = true;

    # Configuración de gráficos híbridos (PRIME) en modo Offload
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus IDs de tu Xiaomi Notebook Pro 15
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia # Monitor de GPU
    nvtopPackages.intel # Monitor de GPU

    # Utilidades sistema
    lm_sensors # Sensores de temperatura
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;
  #
  # # Set your time zone.
  # time.timeZone = "Europe/Madrid";
  #
  # # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  #
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "es_ES.UTF-8";
  #   LC_IDENTIFICATION = "es_ES.UTF-8";
  #   LC_MEASUREMENT = "es_ES.UTF-8";
  #   LC_MONETARY = "es_ES.UTF-8";
  #   LC_NAME = "es_ES.UTF-8";
  #   LC_NUMERIC = "es_ES.UTF-8";
  #   LC_PAPER = "es_ES.UTF-8";
  #   LC_TELEPHONE = "es_ES.UTF-8";
  #   LC_TIME = "es_ES.UTF-8";
  # };
  #
  # # Enable the X11 windowing system.
  # # You can disable this if you're only using the Wayland session.
  # # services.xserver.enable = true;
  # #
  # # # Enable the KDE Plasma Desktop Environment.
  # # services.displayManager.sddm.enable = true;
  # # services.desktopManager.plasma6.enable = true;
  # #
  # # # Configure keymap in X11
  # # services.xserver.xkb = {
  # #   layout = "us";
  # #   variant = "";
  # # };
  # #
  # # # Enable CUPS to print documents.
  # # services.printing.enable = false;
  #
  # # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;
  #
  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };
  #
  # # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  #
  # # Define a user account. Don't forget to set a password with ‘passwd’.
  # # users.users."th3g3ntl3man" = {
  # #   isNormalUser = true;
  # #   description = "The Gentleman";
  # #   extraGroups = [ "networkmanager" "wheel" ];
  # #   packages = with pkgs; [
  # #     kdePackages.kate
  # #   #  thunderbird
  # #   ];
  # # };
  #
  # # Install firefox.
  # programs.firefox.enable = true;
  # programs.zsh.enable = true;
  #
  # # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  # #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  neovim
  #  git
  #  yazi
  #  curl
  #  fd
  #  kitty
  #  alacritty
  #  ghostty
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
