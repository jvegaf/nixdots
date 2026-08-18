{
  imports = [
    # Wrapper-modules (kitty, niri, which-key)
    ./wrappers.nix

    # Neovim (wrapper-modules)
    ./neovim/neovim.nix

    # Simple (single .nix)
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
    ./noctalia

    # Aggregator
    ./environment.nix
  ];
}
