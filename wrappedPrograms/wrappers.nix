{
  inputs,
  self,
  lib,
  ...
}: {
  flake.wrappersModules = {
    kitty = {
      config,
      lib,
      ...
    }: {
      settings = {
        enable_audio_bell = "no";
        scrollback_lines = 10000;
        mouse_hide_wait = 60;
        cursor_trail = 1;
        confirm_os_window_close = 0;

        open_url_with_default = true;
        detect_urls = true;
        allow_remote_control = true;
        shell_integration = "enabled";

        # Clipboard
        map = [
          "ctrl+shift+v        paste_from_selection"
          "shift+insert        paste_from_selection"

          # Scrolling
          "ctrl+shift+up        scroll_line_up"
          "ctrl+shift+down      scroll_line_down"
          "ctrl+shift+k         scroll_line_up"
          "ctrl+shift+j         scroll_line_down"
          "ctrl+shift+page_up   scroll_page_up"
          "ctrl+shift+page_down scroll_page_down"
          "ctrl+shift+home      scroll_home"
          "ctrl+shift+end       scroll_end"
          "ctrl+shift+h         show_scrollback"

          # Window management
          "alt+n               new_window_with_cwd"
          "alt+w               close_window"
          "ctrl+shift+enter    launch --location=hsplit"
          "ctrl+shift+s        launch --location=vsplit"
          "ctrl+shift+]        next_window"
          "ctrl+shift+[        previous_window"
          "ctrl+shift+f        move_window_forward"
          "ctrl+shift+b        move_window_backward"
          "ctrl+shift+`        move_window_to_top"
          "ctrl+shift+1        first_window"
          "ctrl+shift+2        second_window"
          "ctrl+shift+3        third_window"
          "ctrl+shift+4        fourth_window"
          "ctrl+shift+5        fifth_window"
          "ctrl+shift+6        sixth_window"
          "ctrl+shift+7        seventh_window"
          "ctrl+shift+8        eighth_window"
          "ctrl+shift+9        ninth_window"
          "ctrl+shift+0        tenth_window"
          "ctrl+shift+right    next_tab"
          "ctrl+shift+left     previous_tab"
          "ctrl+shift+t        new_tab"
          "ctrl+shift+q        close_tab"
          "ctrl+shift+l        next_layout"
          "ctrl+shift+.        move_tab_forward"
          "ctrl+shift+,        move_tab_backward"

          # Font size
          "ctrl+shift+up      increase_font_size"
          "ctrl+shift+down    decrease_font_size"
          "ctrl+shift+backspace restore_font_size"

          # Tab management
          "alt+1 goto_tab 1"
          "alt+2 goto_tab 2"
          "alt+3 goto_tab 3"
          "alt+4 goto_tab 4"
          "alt+5 goto_tab 5"
          "alt+6 goto_tab 6"
          "alt+7 goto_tab 7"
          "alt+8 goto_tab 8"
          "alt+9 goto_tab 9"
          "ctrl+shift+w close_tab"
          "ctrl+t new_tab_with_cwd"
        ];

        # Catppuccin Mocha
        foreground              = "#cdd6f4";
        background              = "#1e1e2e";
        selection_foreground    = "#1e1e2e";
        selection_background    = "#f5e0dc";

        cursor                  = "#f5e0dc";
        cursor_text_color       = "#1e1e2e";

        url_color               = "#f5e0dc";

        active_border_color     = "#b4befe";
        inactive_border_color   = "#6c7086";
        bell_border_color       = "#f9e2af";

        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";

        active_tab_foreground   = "#11111b";
        active_tab_background   = "#cba6f7";
        inactive_tab_foreground = "#cdd6f4";
        inactive_tab_background = "#181825";
        tab_bar_background      = "#11111b";

        mark1_foreground = "#1e1e2e";
        mark1_background = "#b4befe";
        mark2_foreground = "#1e1e2e";
        mark2_background = "#cba6f7";
        mark3_foreground = "#1e1e2e";
        mark3_background = "#74c7ec";

        color0  = "#45475a";
        color8  = "#585b70";
        color1  = "#f38ba8";
        color9  = "#f38ba8";
        color2  = "#a6e3a1";
        color10 = "#a6e3a1";
        color3  = "#f9e2af";
        color11 = "#f9e2af";
        color4  = "#89b4fa";
        color12 = "#89b4fa";
        color5  = "#f5c2e7";
        color13 = "#f5c2e7";
        color6  = "#94e2d5";
        color14 = "#94e2d5";
        color7  = "#bac2de";
        color15 = "#a6adc8";
      };
    };

    which-key = inputs.wrappers.lib.wrapModule (
      {
        config,
        lib,
        ...
      }: let
        yamlFormat = config.pkgs.formats.yaml {};
      in {
        options = {
          settings = lib.mkOption {
            type = yamlFormat.type;
          };
        };

        config = {
          package = config.pkgs.wlr-which-key;

          args = [
            (toString (yamlFormat.generate "config.yaml" config.settings))
          ];
        };
      }
    );

    niri = {
      config,
      lib,
      pkgs,
      ...
    }: {
      options.terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };
      config = {
        settings = let
          noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia-shell;
        in {
          prefer-no-csd = null;

          input = {
            focus-follows-mouse = null;

            keyboard = {
              xkb = {
                layout = "us,ru,ua";
                options = "grp:alt_shift_toggle,caps:escape";
              };
              repeat-rate = 40;
              repeat-delay = 250;
            };

            touchpad = {
              natural-scroll = null;
              tap = null;
            };

            mouse = {
              accel-profile = "flat";
            };
          };

          binds = {
            "Mod+Return".spawn = config.terminal;

            "Mod+Q".close-window = null;
            "Mod+F".maximize-column = null;
            "Mod+G".fullscreen-window = null;
            "Mod+Shift+F".toggle-window-floating = null;
            "Mod+C".center-column = null;

            "Mod+H".focus-column-left = null;
            "Mod+L".focus-column-right = null;
            "Mod+K".focus-window-up = null;
            "Mod+J".focus-window-down = null;

            "Mod+Left".focus-column-left = null;
            "Mod+Right".focus-column-right = null;
            "Mod+Up".focus-window-up = null;
            "Mod+Down".focus-window-down = null;

            "Mod+Shift+H".move-column-left = null;
            "Mod+Shift+L".move-column-right = null;
            "Mod+Shift+K".move-window-up = null;
            "Mod+Shift+J".move-window-down = null;

            "Mod+1".focus-workspace = "w0";
            "Mod+2".focus-workspace = "w1";
            "Mod+3".focus-workspace = "w2";
            "Mod+4".focus-workspace = "w3";
            "Mod+5".focus-workspace = "w4";
            "Mod+6".focus-workspace = "w5";
            "Mod+7".focus-workspace = "w6";
            "Mod+8".focus-workspace = "w7";
            "Mod+9".focus-workspace = "w8";
            "Mod+0".focus-workspace = "w9";

            "Mod+Shift+1".move-column-to-workspace = "w0";
            "Mod+Shift+2".move-column-to-workspace = "w1";
            "Mod+Shift+3".move-column-to-workspace = "w2";
            "Mod+Shift+4".move-column-to-workspace = "w3";
            "Mod+Shift+5".move-column-to-workspace = "w4";
            "Mod+Shift+6".move-column-to-workspace = "w5";
            "Mod+Shift+7".move-column-to-workspace = "w6";
            "Mod+Shift+8".move-column-to-workspace = "w7";
            "Mod+Shift+9".move-column-to-workspace = "w8";
            "Mod+Shift+0".move-column-to-workspace = "w9";

            "Mod+S".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
            "Mod+V".spawn-sh = ''${config.pkgs.alsa-utils}/bin/amixer sset Capture toggle'';

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

            "Mod+Ctrl+H".set-column-width = "-5%";
            "Mod+Ctrl+L".set-column-width = "+5%";
            "Mod+Ctrl+J".set-window-height = "-5%";
            "Mod+Ctrl+K".set-window-height = "+5%";

            "Mod+WheelScrollDown".focus-column-left = null;
            "Mod+WheelScrollUp".focus-column-right = null;
            "Mod+Ctrl+WheelScrollDown".focus-workspace-down = null;
            "Mod+Ctrl+WheelScrollUp".focus-workspace-up = null;

            "Mod+Ctrl+S".spawn-sh = ''${lib.getExe config.pkgs.grim} -l 0 - | ${config.pkgs.wl-clipboard}/bin/wl-copy'';

            "Mod+Shift+E".spawn-sh = ''${config.pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe config.pkgs.swappy} -f -'';

            "Mod+Shift+S".spawn-sh = lib.getExe (config.pkgs.writeShellApplication {
              name = "screenshot";
              text = ''
                ${lib.getExe config.pkgs.grim} -g "$(${lib.getExe config.pkgs.slurp} -w 0)" - \
                | ${config.pkgs.wl-clipboard}/bin/wl-copy
              '';
            });

            "Mod+d".spawn-sh = self.mkWhichKeyExe config.pkgs [
              {
                key = "b";
                desc = "Bluetooth";
                cmd = "${noctaliaExe} ipc call bluetooth togglePanel";
              }
              {
                key = "w";
                desc = "Wifi";
                cmd = "${noctaliaExe} ipc call wifi togglePanel";
              }
              {
                key = "f";
                desc = "Firefox";
                cmd = "firefox";
              }
              {
                key = "t";
                desc = "Telegram";
                cmd = "Telegram";
              }
              {
                key = "d";
                desc = "Launcher";
                cmd = "${noctaliaExe} ipc call launcher toggle";
              }
              {
                key = "s";
                desc = "Pavucontrol";
                cmd = "${lib.getExe pkgs.pavucontrol}";
              }
            ];
          };

          layout = {
            gaps = 5;

            focus-ring = {
              width = 2;
              active-color = "#fabd2f";
            };
          };

          workspaces = let
            settings = {layout.gaps = 5;};
          in {
            "w0" = settings;
            "w1" = settings;
            "w2" = settings;
            "w3" = settings;
            "w4" = settings;
            "w5" = settings;
            "w6" = settings;
            "w7" = settings;
            "w8" = settings;
            "w9" = settings;
          };

          xwayland-satellite.path =
            lib.getExe config.pkgs.xwayland-satellite;

          spawn-at-startup = [
            noctaliaExe
            (lib.getExe (
              pkgs.writeShellScriptBin "wallpaper"
              "${lib.getExe pkgs.swaybg} -i ${inputs.self + /nixos/features/wallpaper/gruvbox-mountain-village.png} -m fill"
            ))
          ];
        };
      };
    };
  };

  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (
    (self.wrappersModules.which-key.apply {
      inherit pkgs;
      settings = {
        inherit menu;
        font = "JetBrainsMono Nerd Font 12";
        background = "#282828";
        color = "#ebdbb2";
        border = "#cc241d";
        separator = " ➜ ";
        border_width = 2;
        corner_r = 15;
        padding = 15;
        rows_per_column = 5;
        column_padding = 25;
        anchor = "bottom-right";
        margin_right = 0;
        margin_bottom = 5;
        margin_left = 5;
        margin_top = 0;
      };
    }).wrapper
  );

  perSystem = {
    pkgs,
    ...
  }: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;

    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.niri];
    };
  };
}
