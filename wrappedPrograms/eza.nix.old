{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.eza = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.eza;
      flags = {
        "--icons" = "always";
        "--group-directories-first" = "";
        "--header" = "";
        "--git" = "";
        "--colors" = "always";
      };
    };
  };
}
