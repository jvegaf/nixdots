
{
  imports = [
    ./ssh.nix
    # Terminal emulators
    ./alacritty.nix
   # ./wezterm
   #./wezterm.nix

    # Programming & Utils
    ./bat.nix
   # ./fastfetch
   # ./fastfetch.nix

    # Shell & Terminal tools
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./starship.nix
    # ./nixvim.nix

    # Browsers
   # ./chromium.nix
    ./firefox.nix

    # File managers & explorers
    ./ranger.nix
    # ./yazi.nix

    # UI & Display
    # ./hyprland
    # ./waybar
    # ./wofi
    # ./swaync
    # ./dunst.nix

    # Theming
    # ./stylix.nix
    # ./gtk.nix
    # ./qt.nix
    ./fontconfig.nix

    # Document viewers
    ./zathura.nix

    # Git tools
    ./lazygit.nix

    # Editors
    # ./neovim.nix
    ./nixvim/nixvim.nix
    ./eza.nix
    # ./ideavim.nix

    # Disabled
    # ./obsidian.nix
  ];
}
