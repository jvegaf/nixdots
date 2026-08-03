{ ... }:
{
  programs.niri.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
  };
}
