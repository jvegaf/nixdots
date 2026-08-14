{ pkgs, ... }:
{
  gtk = {
    colorScheme = "dark";
    gtk3.colorScheme = "dark";
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Enforce dark theme across Libadwaita applications natively
  home.sessionVariables = {
    ADW_COLOR_SCHEME = "prefer-dark";
  };
}
