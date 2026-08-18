{
  flake.nixosModules.base = {
    lib,
    pkgs,
    ...
  }: {
    options.preferences = {
      keymap = lib.mkOption {
        type = lib.types.lazyAttrsOf (lib.types.either lib.types.attrs lib.types.package);
        default = {};
        example = {
          "SUPER + d" = {
            "f" = {
              exec = "firefox";
            };
          };
        };
      };

      autostart = lib.mkOption {
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.package);
        default = [];
      };
    };
  };
}
