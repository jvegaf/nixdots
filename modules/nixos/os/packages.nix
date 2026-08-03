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
    ntfs3g
    wget
    wl-clipboard
    xclip
    xsel
    p7zip
  ];

}
