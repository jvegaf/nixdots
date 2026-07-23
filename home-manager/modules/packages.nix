{ pkgs, ... }:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    eza
    open-sans
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    platformio-core
    qbittorrent
    ripgrep
    sad
    speedtest-cli
    sshfs
    tealdeer
    telegram-desktop
    tor-browser
    unar
    unrar
    unzip
    uv
    wireguard-tools

    # Unix tools
    fd
    sd
    tree
    gnumake

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt

  ];

  programs = {
    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    btop.enable = true;
    zoxide.enable = true;
  };
}
