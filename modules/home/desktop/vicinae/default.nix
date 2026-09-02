{
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    useLayerShell = true;
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      # bluetooth
      nix
      power-profile
      # Extension names can be found in the link below, it's just the folder names
    ];
    # extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
    #   bluetooth
    #   nix
    #   ssh
    #   # awww-switcher
    #   process-manager
    #   pulseaudio
    #   wifi-commander
    #   port-killer
    #   silverbullet
    # ];

    settings = {
      close_on_focus_loss = false;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      font = {
        normal = {
          size = 10;
          family = "JetBrainsMono Nerd Font";
        };
      };
      theme = {
        light = {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = {
          name = "vicinae-dark";
          icon_theme = "default";
        };
      };
      launcher_window = {
        opacity = 0.98;
      };

      imports = [ "/run/secrets/vicinae.json" ];

      providers = {
        # "@samlinville/store.raycast.tailscale" = {
        #   "preferences" = {
        #     "tailscalePath" = "${pkgs.tailscale}/bin/tailscale";
        #   };
        # };
        # "@sovereign/vicinae-extension-awww-switcher-0" = {
        #   "preferences" = {
        #     "transitionDuration" = "1";
        #     "transitionType" = "center";
        #     "wallpaperPath" = "/home/tux/Wallpapers/";
        #   };
        # };
      };
    };
  };
}
