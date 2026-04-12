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
      "language-token" = "bold";
      "grid-left" = "";
      "grid-right" = "";
    };
  };
}
