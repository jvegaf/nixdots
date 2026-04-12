{ ... }:

# AIDEV-NOTE: Wezterm config managed via XDG config file linking
{
  home.packages = with pkgs; [
    wezterm
  ];

  xdg.configFile."wezterm.lua" = {
    source = ./config.lua;
  };
}
