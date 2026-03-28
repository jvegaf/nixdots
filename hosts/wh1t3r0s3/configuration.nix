{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ./disko.nix
    # AIDEV-NOTE: wh1t3r0s3 usa awesomewm en lugar de hyprland
    ../../nixos/modules/awesome.nix
    ../../nixos/modules/audio.nix
    ../../nixos/modules/bluetooth.nix
    ../../nixos/modules/boot.nix
    ../../nixos/modules/env.nix
    ../../nixos/modules/home-manager.nix
    ../../nixos/modules/kernel.nix
    ../../nixos/modules/mime.nix
    ../../nixos/modules/net.nix
    ../../nixos/modules/nh.nix
    ../../nixos/modules/nix.nix
    ../../nixos/modules/timezone.nix
    ../../nixos/modules/user.nix
    ../../nixos/modules/zram.nix
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}
