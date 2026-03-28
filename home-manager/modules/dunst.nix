{ ... }:

# AIDEV-NOTE: Dunst notification daemon configuration
{
  home.packages = with pkgs; [
    dunst
  ];

  # Dunst configuration
  home.file.".config/dunst/dunstrc" = {
    text = ''
      [global]
          font = JetBrains Mono 11

          # Allow markup in notifications
          allow_markup = yes

          # Notification format
          format = "<b>%s</b>\n%b"

          # Sort by urgency
          sort = yes
          indicate_hidden = yes

          # Alignment
          alignment = center
          word_wrap = yes
          ignore_newline = no

          # Geometry
          geometry = "300x250-15+50"

          # Frame
          frame_width = 0
          frame_color = "#89b4fa"

          # Transparency
          transparency = 0

          # Idle threshold
          idle_threshold = 0
          monitor = 0

          # Follow mode
          follow = none

          # History
          sticky_history = yes

          # Spacing
          line_height = 8
          separator_height = 2
          padding = 8
          horizontal_padding = 8

          # Separator color
          separator_color = frame

          # Startup
          startup_notification = false

          # Browser
          browser = /usr/bin/firefox

          # Icons
          icon_position = left
          max_icon_size = 40

      [shortcuts]
          close = ctrl+space
          close_all = ctrl+shift+space
          history = ctrl+grave
          context = ctrl+shift+period

      [urgency_low]
          background = "#1e1e28"
          foreground = "#dadae8"
          timeout = 3

      [urgency_normal]
          background = "#1e1e28"
          foreground = "#dadae8"
          timeout = 5

      [urgency_critical]
          background = "#1e1e28"
          foreground = "#f38ba8"
          timeout = 10
    '';
  };

  # Start dunst on Hyprland startup
  # (via exec-once in hyprland/main.nix or here)
  systemd.user.startServices = true;
}
