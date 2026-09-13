{
  # Enable SDDM and its Wayland capabilities
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # optional, runs SDDM under Wayland if supported
  };
}
