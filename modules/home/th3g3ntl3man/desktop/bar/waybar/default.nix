{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.modules.desktop.bar;
in
{
  config = mkIf (cfg == "waybar") {
    programs.waybar = {
      enable = true;
      # style = ./style.css;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "sway/workspaces" ];
          modules-center = [ "sway/window" ];
          modules-right = [
            "custom/weather"
            "pulseaudio"
            "battery"
            "clock"
            "tray"
          ];
          "sway/workspaces" = {
            disable-scroll = true;
            show-special = true;
            special-visible-only = true;
            all-outputs = false;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              "9" = "";
              "magic" = "";
            };

            persistent-workspaces = {
              "*" = 9;
            };
          };

          "custom/weather" = {
            format = " {} ";
            exec = "curl -s 'wttr.in/Madrid?format=%c%t'";
            interval = 300;
            class = "weather";
          };

          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}% ";
            format-muted = "";
            format-icons = {
              "headphones" = "";
              "handsfree" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = [
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 1;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-alt = "{time} {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "clock" = {
            format = "{:%d.%m.%Y - %H:%M}";
            format-alt = "{:%A, %B %d at %R}";
          };

          "tray" = {
            icon-size = 14;
            spacing = 1;
          };
        };
      };
    };
  };
}
