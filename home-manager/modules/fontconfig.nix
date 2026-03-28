{ ... }:

# AIDEV-NOTE: Fontconfig configuration for system fonts
{
  fonts.fontconfig = {
    enable = true;

    # Subpixel rendering and hinting
    antialias = true;
    hinting = true;
    hintstyle = "hintslight";
    rgba = "rgb";
    lcdfilter = "lcdnone";

    # DPI setting
    dpi = 102;
  };

  # Link custom fonts.conf if needed
  # xdg.configFile."fontconfig/fonts.conf" = {
  #   source = ./fonts.conf;
  # };
}
