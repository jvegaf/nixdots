{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = null;
    portalPackage = null;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",preferred,auto, auto";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      general = {
        gaps_in = 05;
        gaps_out = 10;

        border_size = 2;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 12;

        active_opacity = 1.0;
        inactive_opacity = 0.7;

        shadow = {
          enabled = true;
        };

        blur = {
          enabled = true;
        };
      };

      animations = {
        enabled = true;
        # animation = "windowsIn,1,5,default,popin 0%";
        # animation = "windowsOut,1,5,default,popin";
        # animation = "windowsMove,1,5,default,slide";
        # animation = "layersIn,1,4,default,slide";
        # animation = "layersOut,1,4,default,slide";
        # animation = "fadeIn,1,8,default";
        # animation = "fadeOut,1,8,default";
        # animation = "fadeSwitch,1,8,default";
        # animation = "fadeShadow,1,8,default";
        # animation = "fadeDim,1,8,default";
        # animation = "fadeLayersIn,1,8,default";
        # animation = "fadeLayersOut,1,8,default";
        # animation = "fadePopupsIn,1,5,default";
        # animation = "fadePopupsOut,1,5,default";
        # animation = "fadeDpms,1,10,default";
        # animation = "border,1,20,default";
        # animation = "borderangle,1,20,default,once";
        # animation = "workspacesIn, 1,5,default,slide";
        # animation = "workspacesOut, 1,5,default,slide";
        # animation = "specialWorkspaceIn,1,5,default,fade";
        # animation = "specialWorkspaceOut,1,5,default,fade";
        # animation = "zoomFactor,1,10,default";
        # animation = "monitorAdded,1,10,default";
      };

      input = {
        kb_layout = "us";
        # kb_options = "grp:caps_toggle";
      };

      # gestures = {
      #   workspace_swipe = true;
      #   workspace_swipe_invert = false;
      #   workspace_swipe_forever	= true;
      # };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # windowrule = [
      #   "bordersize 0, floating:0, onworkspace:w[t1]"
      #
      #   "float,class:(mpv)|(imv)|(showmethekey-gtk)"
      #   "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
      #   "noborder,nofocus,class:(showmethekey-gtk)"
      #
      #   "workspace 3,class:(obsidian)"
      #   "workspace 3,class:(zathura)"
      #   "workspace 4,class:(com.obsproject.Studio)"
      #   "workspace 5,class:(telegram)"
      #   "workspace 5,class:(vesktop)"
      #   "workspace 6,class:(teams-for-linux)"
      #
      #   "suppressevent maximize, class:.*"
      #   "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      #
      #   "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      #   "noanim, class:^(xwaylandvideobridge)$"
      #   "noinitialfocus, class:^(xwaylandvideobridge)$"
      #   "maxsize 1 1, class:^(xwaylandvideobridge)$"
      #   "noblur, class:^(xwaylandvideobridge)$"
      #   "nofocus, class:^(xwaylandvideobridge)$"
      # ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };
  };
}
