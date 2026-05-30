{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.creality-print;
  # Importamos el paquete que definimos en el paso anterior
  creality-print = pkgs.callPackage ./packages/creality-print.pkg.nix {};
in {
  options.programs.creality-print = {
    enable = mkEnableOption "Creality Print Slicer";
  };

  config = mkIf cfg.enable {
    # Instala el paquete en el sistema
    environment.systemPackages = [ 
      creality-print
      (pkgs.makeDesktopItem {
        name = "creality-print";
        desktopName = "Creality Print";
        exec = "${creality-print}/bin/creality-print";
        icon = "3d-printer"; # Puedes cambiarlo por una ruta a un icono .png si lo deseas
        comment = "Laminador 3D oficial de Creality";
        categories = [ "Utility" "Graphics" "3DGraphics" ];
      })
    ];

    # Opcional: Si el laminador necesita comunicarse por red local con la impresora 
    # mediante mDNS/Avahi (descubrimiento automático de la K1/K1C en la LAN),
    # nos aseguramos de que el servicio mDNS esté activo.
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

}
