{ pkgs, ... }: {
  
  # Kickstart ya habilita programs.nixvim.enable = true;
  # Aquí solo añades tus personalizaciones extra:
  programs.nixvim = {
    # Tus atajos de teclado personalizados
    keymaps = [
      {
        key = "W";
        mode = [ "n" ];
        action = "<CMD>write<CR>";
        options.desc = "Guardar archivo";
      }
    ];

    colorschemes.vim.enable = true;
    # Si quieres cambiar alguna opción que Kickstart trae por defecto
    opts = {
      relativenumber = true;
    };
  };

  home.stateVersion = "25.11";
}
