{
  flake.nixosModules.base = {
    lib,
    ...
  }: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "th3g3ntl3man";
      };
    };
  };
}
