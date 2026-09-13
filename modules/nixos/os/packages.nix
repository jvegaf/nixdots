{ pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    curl
    fd
    git
    jq
    less
    lm_sensors
    lshw
    nix-output-monitor
    nmap
    ntfs3g
    p7zip
    pciutils
    procs
    pv
    ranger
    ripgrep
    sops
    ssh-to-age
    tree
    unzip
    unar
    wget
  ];
}
