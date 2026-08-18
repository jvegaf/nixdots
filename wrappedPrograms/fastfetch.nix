{
  inputs,
  pkgs,
  ...
}: let
  fastfetchConfig = pkgs.writeText "config.jsonc" ''
    {
      "logo": {
        "source": "nixos_small",
        "padding": {
          "right": 1
        }
      },
      "display": {
        "size": {
          "binaryPrefix": "SI"
        },
        "color": "blue",
        "separator": " → "
      },
      "modules": [
        {
          "type": "datetime",
          "key": "Date",
          "format": "{1}-{3}-{11}"
        },
        {
          "type": "datetime",
          "key": "Time",
          "format": "{14}:{17}:{20}"
        },
        "break",
        "player",
        "media"
      ]
    }
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.fastfetch = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fastfetch;
      flags = {
        "--config" = fastfetchConfig;
      };
    };
  };
}
