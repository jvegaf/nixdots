{ ... }:

# AIDEV-NOTE: Fastfetch config is managed via XDG config file linking
{
  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.configFile."fastfetch/config.jsonc" = {
    source = ./config.jsonc;
  };
}
