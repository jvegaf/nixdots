{ pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pciutils
    lshw
    nmap
    curl
    nh
    ntfs3g
    openssh
    wget
    wl-clipboard
    xclip
    xsel
    p7zip
  ];

}
