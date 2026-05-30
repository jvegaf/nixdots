{ config, pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    steam-run
    pciutils
    lshw
    nvtopPackages.nvidia
    nvtopPackages.intel
    nmap
    curl
    gnome-keyring
    nh
    ntfs3g
    openssh
    power-profiles-daemon
    wget
    wl-clipboard
    xclip
    xsel
  ];

}
