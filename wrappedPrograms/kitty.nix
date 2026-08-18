{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.kitty = {
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

  perSystem = {pkgs, ...}: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;
  };
}
