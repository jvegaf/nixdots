{ pkgs, ... }: {

  imports = [
    ../waybar_3
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  wayland.windowManager.niri = {
    enable = true;
    systemd.enable = true;
    settings = {
      screenshot-path = null;
      prefer-no-csd = { };
      # spawn-at-startup = [ "waybar" ];

      input = {
        keyboard.xkb.layout = [ "us" ];
        touchpad.tap = { };
        touchpad.natural-scroll = { };
        warp-mouse-to-focus = { };
        workspace-auto-back-and-forth = { };
      };

      binds = {
        "Mod+Shift+H".show-hotkey-overlay = { };

        "Mod+Return" = {
          _props.hotkey-overlay-title = "Open Terminal: Kitty";
          spawn = [ "kitty" ];
        };
        "Mod+D" = {
          _props.hotkey-overlay-title = "Open App Launcher: fuzzel";
          spawn = [
            "fuzzel"
          ];
        };
        "Mod+E" = {
          _props.hotkey-overlay-title = "File Manager: Nautilus";
          spawn = [ "nautilus" ];
        };
        "MOD+B" = {
          _props.hotkey-overlay-title = "Open Browser: firefox";
          spawn = [ "firefox" ];
        };
        "MOD+ALT+L" = {
          _props.hotkey-overlay-title = "Lock Screen: swaylock";
          spawn = [ "swaylock" ];
        };

        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call volume increase" ];
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call volume decrease" ];
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call volume muteOutput" ];
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call volume muteInput" ];
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call media next" ];
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call media previous" ];
        };
        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call media playPause" ];
        };
        "XF86AudioPause" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call media playPause" ];
        };
        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call brightness increase" ];
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "qs -c noctalia-shell ipc call brightness decrease" ];
        };

        "Mod+Q".close-window = { };
        "Mod+Left".focus-column-left = { };
        "Mod+Down".focus-window-down = { };
        "Mod+Up".focus-window-up = { };
        "Mod+Right".focus-column-right = { };
        "Mod+H".set-column-width = [ "-10%" ];
        "Mod+J".set-window-height = [ "-10%" ];
        "Mod+K".set-window-height = [ "+10%" ];
        "Mod+L".set-column-width = [ "+10%" ];
        "Mod+CTRL+Left".move-column-left = { };
        "Mod+CTRL+H".move-column-left = { };
        "Mod+CTRL+Right".move-column-right = { };
        "Mod+CTRL+L".move-column-right = { };
        "Mod+CTRL+UP".move-window-up = { };
        "Mod+CTRL+K".move-window-up = { };
        "Mod+CTRL+Down".move-window-down = { };
        "Mod+CTRL+J".move-window-down = { };
        "Mod+Home".focus-column-first = { };
        "Mod+End".focus-column-last = { };
        "Mod+CTRL+Home".move-column-to-first = { };
        "Mod+CTRL+End".move-column-to-last = { };
        "Mod+Shift+Left".focus-monitor-left = { };
        "Mod+Shift+Right".focus-monitor-right = { };
        "Mod+Shift+UP".focus-monitor-up = { };
        "Mod+Shift+Down".focus-monitor-down = { };
        "Mod+Shift+CTRL+Left".move-column-to-monitor-left = { };
        "Mod+Shift+CTRL+Right".move-column-to-monitor-right = { };
        "Mod+Shift+CTRL+UP".move-column-to-monitor-up = { };
        "Mod+Shift+CTRL+Down".move-column-to-monitor-down = { };

        "Mod+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          focus-workspace-up = { };
        };
        "Mod+CTRL+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-down = { };
        };
        "Mod+CTRL+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-up = { };
        };
        "Mod+WheelScrollRight".focus-column-right = { };
        "Mod+WheelScrollLeft".focus-column-left = { };
        "Mod+CTRL+WheelScrollRight".move-column-right = { };
        "Mod+CTRL+WheelScrollLeft".move-column-left = { };
        "Mod+Shift+WheelScrollDown".focus-column-right = { };
        "Mod+Shift+WheelScrollUp".focus-column-left = { };
        "Mod+CTRL+Shift+WheelScrollDown".move-column-right = { };
        "Mod+CTRL+Shift+WheelScrollUp".move-column-left = { };

        "Mod+1".focus-workspace = [ 1 ];
        "Mod+2".focus-workspace = [ 2 ];
        "Mod+3".focus-workspace = [ 3 ];
        "Mod+4".focus-workspace = [ 4 ];
        "Mod+5".focus-workspace = [ 5 ];
        "Mod+6".focus-workspace = [ 6 ];
        "Mod+7".focus-workspace = [ 7 ];
        "Mod+8".focus-workspace = [ 8 ];
        "Mod+9".focus-workspace = [ 9 ];
        "Mod+CTRL+1".move-column-to-workspace = [ 1 ];
        "Mod+CTRL+2".move-column-to-workspace = [ 2 ];
        "Mod+CTRL+3".move-column-to-workspace = [ 3 ];
        "Mod+CTRL+4".move-column-to-workspace = [ 4 ];
        "Mod+CTRL+5".move-column-to-workspace = [ 5 ];
        "Mod+CTRL+6".move-column-to-workspace = [ 6 ];
        "Mod+CTRL+7".move-column-to-workspace = [ 7 ];
        "Mod+CTRL+8".move-column-to-workspace = [ 8 ];
        "Mod+CTRL+9".move-column-to-workspace = [ 9 ];
        "Mod+TAB".focus-workspace-previous = { };

        "Mod+CTRL+F".expand-column-to-available-width = { };
        "Mod+C".center-column = { };
        "Mod+CTRL+C".center-visible-columns = { };
        "Mod+T".toggle-window-floating = { };
        "MOD+F".maximize-column = { };
        "MOD+SHIFT+F".fullscreen-window = { };
        "Mod+W".toggle-column-tabbed-display = { };
        "CTRL+Shift+1".screenshot = { };
        "CTRL+Shift+2".screenshot-screen = { };
        "CTRL+Shift+3".screenshot-window = { };
        "Mod+ESCAPE" = {
          _props.allow-inhibiting = false;
          toggle-keyboard-shortcuts-inhibit = { };
        };
        "CTRL+ALT+Delete".quit = { };
        "Mod+Shift+P".power-off-monitors = { };
        "Mod+O" = {
          _props.repeat = false;
          toggle-overview = { };
        };
      };

      layout = {
        gaps = 12;
        center-focused-column = [ "never" ];
        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        focus-ring = {
          width = 3;
          active-color = "#00ac89";
          inactive-color = "#4F4F4F";
        };
        shadow = {
          softness = 30;
          spread = 5;
          offset._props = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };
        struts = { };
      };

      animations._children = [
        {
          workspace-switch.spring._props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0001;
          };
        }
        {
          window-open = {
            duration-ms = 200;
            curve = [ "ease-out-quad" ];
          };
        }
        {
          window-close = {
            duration-ms = 200;
            curve = [ "ease-out-cubic" ];
          };
        }
        {
          horizontal-view-movement.spring._props = {
            damping-ratio = 1.0;
            stiffness = 900;
            epsilon = 0.0001;
          };
        }
        {
          window-movement.spring._props = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        }
        {
          window-resize.spring._props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0001;
          };
        }
        {
          config-notification-open-close.spring._props = {
            damping-ratio = 0.6;
            stiffness = 1200;
            epsilon = 0.001;
          };
        }
        {
          screenshot-ui-open = {
            duration-ms = 300;
            curve = [ "ease-out-quad" ];
          };
        }
        {
          overview-open-close.spring._props = {
            damping-ratio = 1.0;
            stiffness = 900;
            epsilon = 0.0001;
          };
        }
      ];

      environment = {
        DISPLAY = ":1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
      };

      cursor = {
        hide-when-typing = { };
        hide-after-inactive-ms = [ 1000 ];
      };
      hotkey-overlay.skip-at-startup = { };

      _children = [
        {
          output = {
            _args = [ "eDP-1" ];
            mode = [ "2560x1440@60.000" ];
            scale = 1.33;
          };
        }
        {
          output = {
            _args = [ "HDMI-A-1" ];
            mode = [ "1920x1080@60.000" ];
            scale = 1;
          };
        }
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              };
            }
            { match._props.app-id = "1password"; }
            { match._props.app-id = "org.pulseaudio.pavucontrol"; }
            { match._props.app-id = "nm-connection-editor"; }
            { match._props.title = "^Welcome to Android Studio$"; }
            { open-floating = true; }
          ];
        }
        {
          window-rule._children = [
            { geometry-corner-radius = 10; }
            { clip-to-geometry = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "firefox"; }
            { match._props.app-id = "FreeCAD"; }
            { match._props.app-id = "org.QCAD.qcad-bin"; }
            { match._props.app-id = "code"; }
            { match._props.app-id = "code-insiders"; }
            { match._props.app-id = "thunar"; }
            { match._props.app-id = "jetbrains-studio"; }
            { match._props.app-id = "kicad"; }
            { open-maximized = true; }
          ];
        }
      ];
    };
  };

  programs.quickshell.enable = true;
  programs.quickshell.systemd.enable = true;
  programs.fuzzel.enable = true;
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.swayidle.enable = true; # idle management daemon
  # services.polkit-gnome.enable = true; # polkit

}
