{
  flake.nixosModules.pipewire = {pkgs, ...}: {
    preferences.keymap = {
      "SUPER + v".exec = ''${pkgs.alsa-utils}/bin/amixer sset Capture toggle'';
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
