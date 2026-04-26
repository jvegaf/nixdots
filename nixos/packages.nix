{ config, pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pciutils
    lshw
    nvtopPackages.nvidia
    nmap
    curl
    fd
    gnome-keyring
    nh
    ntfs3g
    openssh
    power-profiles-daemon
    tree
    wget
    wl-clipboard
    xclip
    xsel
  ];

}
