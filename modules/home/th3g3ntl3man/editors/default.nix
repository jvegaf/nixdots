{
  lib,
  ...
}:

let
  inherit (lib) types mkOption;
in
{
  imports = [
    ./nixvim
    ./lazyvim
    ./zed
    ./evil-helix.nix
  ];

  options.modules.editor = {
    neovim = mkOption {
      type =
        with types;
        nullOr (enum [
          "lazyvim"
          "nixvim"
        ]);
      default = null;
      description = "Which neovim module to use";
    };
  };

}
