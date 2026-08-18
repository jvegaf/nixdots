{
  inputs,
  pkgs,
  ...
}: let
  starshipConfig = pkgs.writeText "starship.toml" ''
    [gcloud]
    disabled = true

    [username]
    style_user = "blue bold"
    style_root = "red bold"
    format = "[$user]($style) "
    disabled = false
    show_always = true

    [hostname]
    ssh_only = false
    ssh_symbol = "🌐 "
    format = "on [$hostname](bold red) "
    trim_at = ".local"
    disabled = false
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.starship = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.starship;
      env = {
        STARSHIP_CONFIG = starshipConfig;
      };
    };
  };
}
