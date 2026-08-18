{
  flake.nixosModules.firefox = {pkgs, ...}: {
    programs.firefox.enable = true;

    preferences.keymap = {
      "SUPER + d"."f".package = pkgs.firefox;
    };
  };
}
