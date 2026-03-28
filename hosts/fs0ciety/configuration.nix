{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    # AIDEV-NOTE: Razer Blade 15 Advanced 2021 (RTX 3070) specific config
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  networking.networkmanager.enable = true;

  system.stateVersion = stateVersion;

  services.xserver.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  programs.ssh.startAgent = true
  
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  networking.firewall.enable = false;
}

