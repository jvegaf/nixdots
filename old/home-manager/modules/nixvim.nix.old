{ lib, ... }: {
  # TODO lo de Nixvim debe ir dentro de este bloque
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Ahora sí, estas opciones pertenecen a Nixvim
    clipboard.register = "unnamedplus";

    keymaps = [
      {
        key = "W";
        mode = [ "n" ];
        action = "<CMD>write<CR>";
      }
      {
        key = "Q";
        mode = [ "n" ];
        action = "<CMD>bdelete<CR>";
      }
    ];

    # Opciones adicionales recomendadas
    opts = {
      number = true;
      relativenumber = true;
    };
  };
}
