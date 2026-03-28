{ pkgs, ... }:

# AIDEV-NOTE: Bat configuration with Catppuccin theme
{
  programs.bat = {
    enable = true;

    # Theme is set via BAT_THEME env var in zsh.nix
    # Default theme: Catppuccin Macchiato

    config = {
      # Show line numbers and borders
      "number" = true;
      "rule" = true;
      "plain" = false;
      "italic-text" = "always";
      "paging" = "never";
      "tabs" = 4;
      "language-token" = "bold";
      "grid-left" = "";
      "grid-right" = "";
    };

    # Catppuccin Macchiato theme
    themes = {
      "Catppuccin Macchiato" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "dc9e23c16fca01d0cb9aba8a0bbc651a44c5f5eb";
          sha256 = "sha256-abc123";
        };
        file = "Catppuccin Macchiato.tmTheme";
      };
    };
  };
}
