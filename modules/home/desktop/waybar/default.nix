{ pkgs, config, ... }:
{

  home.file.".config/waybar/scripts/weather.sh".source = ./weather.sh;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "niri.service" ];
    };

    style = builtins.readFile ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        height = 38;

        modules-left = [
          "niri/workspaces"
          "cpu"
          "memory"
          "temperature"
        ];
        modules-center = [
          "clock"
          "custom/weather"
        ];
        modules-right = [
          "tray"
          "bluetooth"
          "network"
          "backlight"
          "pulseaudio"
          "battery"
        ];

        "cpu" = {
          interval = 10;
          format = " {}%";
          max-length = 10;
        };

        "memory" = {
          interval = 30;
          format = "  {used:0.1f}G/{total:0.1f}G";
        };

        "temperature" = {
          thermal-zone = 2;
          critical-threshold = 80;
          format-critical = "{temperatureC }°C ";
          format = "{temperatureC}°C ";
        };

        "clock" = {
          format = "󰃭 {:%d.%m.%Y - %H:%M}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#dfa742'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{:%V}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click = "mode";
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "custom/weather" = {
          format = "{}";
          return-type = "json";
          interval = 60;
          exec = "~/.config/waybar/scripts/weather.sh";
          escape = false;
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
        };

        "battery" = {
          states = {
            "warning" = 30;
            "critical" = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-update = "if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 15 ] && [ $(cat /sys/class/power_supply/BAT0/status) = 'Discharging' ]; then notify-send -u critical 'Battery Low!' 'Please connect your charger.'; fi";
        };

        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-connected = " {num_connections} connected";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "rofi-bluetooth";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pwmenu -l fuzzel";
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "  {essid} ({signalStrength}%) ";
          format-ethernet = "󰛳 Wired";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr} 󰛳";
          tooltip-format-wifi = "  {essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "󰛳 {ifname}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "rofi-network-manager";
        };
      };
    };
  };

}
