{ pkgs, ... }:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    open-sans
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    # platformio-core
    # qbittorrent
    sad
    speedtest-cli
    sshfs
    # telegram-desktop
    unar
    # unrar
    # unzip
    # uv
    # wireguard-tools

    # Unix tools
    sd
    tree
    gnumake

    # Nix dev
    just
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt

    # Gentle AI (custom package, see pkgs/gentle-ai)
    # gentle-ai
    # Engram (persistent memory, NUR congee: Gentleman-Programming/engram)
    nur.repos.congee.engram

  ];

  programs = {
    fd.enable = true;
    ripgrep.enable = true;
    fzf.enable = true;
    jq.enable = true;
    zoxide.enable = true;
  };
}
