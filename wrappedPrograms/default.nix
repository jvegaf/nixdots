{
  imports = [
    # Simple (single .nix)
    ./kitty.nix
    ./git.nix
    ./lazygit.nix
    ./zsh.nix
    ./starship.nix
    ./bat.nix
    ./eza.nix
    ./btop.nix
    ./nh.nix
    ./fastfetch.nix
    ./tmux.nix
    ./yazi.nix
    ./helix.nix
    ./ghostty.nix
    ./nix-search-tv.nix

    # With config files (directory)
    ./alacritty
    ./tealdeer
    ./zellij
    ./zed

    # Aggregator
    ./environment.nix
  ];
}
