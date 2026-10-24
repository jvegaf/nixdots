{ pkgs, inputs, ... }: {
  services.displayManager.noctalia-greeter = {
    enable = true;

    extraArgs = [ "--session Niri" ];
    settings = {
      cursor = {
        theme = "Breeze_Light";
        size = 24;
        path = "${pkgs.kdePackages.breeze}/share/icons";
      };

      keyboard = {
        layout = "us";
      };

      output = {
        scale = 1.25;
        name = "eDP-1";
      };
    };
  };
}
