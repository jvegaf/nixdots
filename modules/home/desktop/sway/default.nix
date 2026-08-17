{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../common/stylix.nix
    # ./keymap.nix
  ];

  home.packages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    libappindicator-gtk3
    networkmanagerapplet
    wmenu
    fuzzel
    thunar
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];

  # programs.i3status-rust.enable = true;

  services.gnome-keyring.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;
    config = {
      gaps = {
        smartBorders = "on";
      };
      fonts = {
        names = [
          "Iosevka"
          "Font Awesome 6 Free"
          "Font Awesome 6 Brands"
        ];
      };
      modifier = "Mod4";
      menu = "fuzzel";
      terminal = "ghostty";
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+q" = "kill";
          "${mod}+Shift+e" = "exit";
          "${mod}+b" = "exec firefox";
          "${mod}+e" = "exec thunar";
          "${mod}+Shift+s" = "exec slack --logLevel=error";
          "${mod}+m" = "output eDP-1 enable";
          # "${mod}+Shift+m" = "output eDP-1 disable";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "--release Print" = "exec GRIM_DEFAULT_DIR=~/scr grim -g \"$(slurp)\"";
          "--release ${mod}+Print" = "exec GRIM_DEFAULT_DIR=~/scr grim";
        };
      # colors = {
      #   focused = {
      #     background = "#b16286";
      #     border = "#b16286";
      #     childBorder = "#b16286";
      #     indicator = "#b16286";
      #     text = "#ebdbb2";
      #   };
      #   focusedInactive = {
      #     background = "#689d6a";
      #     border = "#689d6a";
      #     childBorder = "#689d6a";
      #     indicator = "#689d6a";
      #     text = "#ebdbb2";
      #   };
      #   unfocused = {
      #     background = "#3c3836";
      #     border = "#3c3836";
      #     childBorder = "#3c3836";
      #     indicator = "#3c3836";
      #     text = "#ebdbb2";
      #   };
      #   urgent = {
      #     background = "#cc241d";
      #     border = "#cc241d";
      #     childBorder = "#cc241d";
      #     indicator = "#cc241d";
      #     text = "#ebdbb2";
      #   };
      #   placeholder = {
      #     background = "#000000";
      #     border = "#000000";
      #     childBorder = "#000000";
      #     indicator = "#000000";
      #     text = "#ebdbb2 ";
      #   };
      # };
      bars = [
      ];
      input = {
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "20";
        };
        "type:touchpad" = {
          dwt = "enabled";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };
      output = {
        eDP-1 = {
          pos = "0 0";
          scale = "2";
        };
      };
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
        commands = [
          {
            command = "floating enable";
            criteria = {
              app_id = "gsimplecal";
            };
          }
          {
            command = "floating enable";
            criteria = {
              app_id = "firefox";
              title = "About Mozilla Firefox";
            };
          }
          {
            command = "move container to workspace 2";
            criteria = {
              app_id = "^(?i)slack$";
            };
          }
          {
            command = "move container to workspace 3";
            criteria = {
              app_id = "firefox";
            };
          }
          {
            command = "floating enable";
            criteria = {
              title = "Save File";
            };
          }
          # browser zoom|meet|bluejeans
          {
            command = "inhibit_idle visible";
            criteria = {
              title = "(Blue Jeans)|(Meet)|(Zoom Meeting)";
            };
          }
        ];
      };
      startup = [
        {
          command = ''
            swayidle -w \
                timeout 300 'swaylock --daemonize --color 3c3836' \
                timeout 600 'swaymsg "output * dpms off"' \
                     resume 'swaymsg "output * dpms on"' \
                before-sleep 'swaylock --daemonize --color 3c3836'
          '';
        }
      ];
    };
    extraConfig = ''
      seat seat0 xcursor_theme "capitaine-cursors"
      seat seat0 hide_cursor 60000
    '';
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {

      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
        ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "wlr/taskbar"
        ];
        modules-center = [
          "sway/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "mpd"
          "cpu"
          "memory"
          "temperature"
          "network"
          "tray"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "temperature" = {
          thermal_zone = 0;
          critical-threshold = 80;
          format = "{temperatureC}°C ";
        };
        "clock" = {
          format = " {:L%H:%M}";
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
      };

    };

    style = lib.concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: 16px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        #workspaces {
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base01};
          margin: 4px 4px;
          padding: 5px 5px;
          border-radius: 16px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${config.lib.stylix.colors.base00};
          background: linear-gradient(45deg, #${config.lib.stylix.colors.base08}, #${config.lib.stylix.colors.base0D});
          opacity: 0.5;
          transition: ${betterTransition};
        }
        #workspaces button.active {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${config.lib.stylix.colors.base00};
          background: linear-gradient(45deg, #${config.lib.stylix.colors.base08}, #${config.lib.stylix.colors.base0D});
          transition: ${betterTransition};
          opacity: 1.0;
          min-width: 40px;
        }
        #workspaces button:hover {
          font-weight: bold;
          border-radius: 16px;
          color: #${config.lib.stylix.colors.base00};
          background: linear-gradient(45deg, #${config.lib.stylix.colors.base08}, #${config.lib.stylix.colors.base0D});
          opacity: 0.8;
          transition: ${betterTransition};
        }
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base08};
          border-radius: 12px;
        }
        tooltip label {
          color: #${config.lib.stylix.colors.base08};
        }
        #window, #pulseaudio, #cpu, #memory, #idle_inhibitor {
          font-weight: bold;
          margin: 4px 0px;
          margin-left: 7px;
          padding: 0px 18px;
          background: #${config.lib.stylix.colors.base04};
          color: #${config.lib.stylix.colors.base00};
          border-radius: 24px 10px 24px 10px;
        }
        #custom-startmenu {
          color: #${config.lib.stylix.colors.base0B};
          background: #${config.lib.stylix.colors.base02};
          font-size: 28px;
          margin: 0px;
          padding: 0px 30px 0px 15px;
          border-radius: 0px 0px 40px 0px;
        }
        #custom-hyprbindings, #network, #battery,
        #custom-notification, #tray, #custom-exit {
          font-weight: bold;
          background: #${config.lib.stylix.colors.base0F};
          color: #${config.lib.stylix.colors.base00};
          margin: 4px 0px;
          margin-right: 7px;
          border-radius: 10px 24px 10px 24px;
          padding: 0px 18px;
        }
        #clock {
          font-weight: bold;
          color: #0D0E15;
          background: linear-gradient(90deg, #${config.lib.stylix.colors.base0E}, #${config.lib.stylix.colors.base0C});
          margin: 0px;
          padding: 0px 15px 0px 30px;
          border-radius: 0px 0px 0px 40px;
        }
      ''
    ];
  };
}
