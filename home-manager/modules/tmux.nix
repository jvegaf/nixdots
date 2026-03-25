{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";

    # Catppuccin Mocha theme colors
    extraConfig = ''
      # AIDEV-NOTE: Tmux configuration with Catppuccin theme

      # Terminal features
      set -as terminal-features ",xterm-256color:rgb"
      set -as terminal-features ',rxvt-unicode-256color:clipboard'

      # Reload config
      bind -n M-r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Prefix and keybinds
      unbind-key C-b
      set -g prefix M-a
      bind-key M-a send-prefix

      # Window/pane titles
      set-option -g allow-rename on
      set-option -g set-titles on
      set-option -g set-titles-string '#t'

      # Quick window selection
      bind -n C-1 select-window -t 1
      bind -n C-2 select-window -t 2
      bind -n C-3 select-window -t 3
      bind -n C-4 select-window -t 4
      bind -n C-5 select-window -t 5
      bind -n C-6 select-window -t 6
      bind -n C-7 select-window -t 7
      bind -n C-8 select-window -t 8
      bind -n C-9 select-window -t 9

      # Pane navigation with Alt+arrows
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Pane resizing
      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Up resize-pane -U 3
      bind -n M-S-Down resize-pane -D 3

      # Window cycling
      bind C-p previous-window
      bind C-n next-window

      # Open panes in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      unbind .
      bind . split-window -h -c "#{pane_current_path}"

      # Kill bindings
      bind x kill-pane
      bind e kill-window
      bind -n M-Q kill-session

      # VI mode
      setw -g mode-keys vi
      set -g status-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # Smart pane switching with Vim awareness
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      # -------------------------------------------
      # Catppuccin Mocha Theme
      # -------------------------------------------
      # Color palette
      thm_bg="#1e1e28"
      thm_fg="#dadae8"
      thm_cyan="#c2e7f0"
      thm_black="#15121c"
      thm_gray="#332e41"
      thm_magenta="#c6aae8"
      thm_pink="#e5b4e2"
      thm_red="#e38c8f"
      thm_green="#b1e3ad"
      thm_yellow="#ebddaa"
      thm_blue="#a4b9ef"
      thm_orange="#f9c096"
      thm_black4="#575268"

      # Status bar
      set -g status on
      set -g status-interval 1
      set -g status-justify centre
      set -g status-position top
      set -g status-style fg=colour136,bg=colour235

      # Status left
      set -g status-left-length 20
      set -g status-left "#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r)#[default]"

      # Status right
      set -g status-right-length 140
      set -g status-right "#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) "
      set -ag status-right "#[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') "
      set -ag status-right " #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d"

      # Window status
      set-window-option -g window-status-style fg=colour244
      set-window-option -g window-status-style bg=default
      set-window-option -g window-status-current-style fg=colour166
      set-window-option -g window-status-current-style bg=default

      # Messages
      set -g message-style fg="${thm_cyan}",bg="${thm_gray}",align="centre"
      set -g message-command-style fg="${thm_cyan}",bg="${thm_gray}",align="centre"

      # Panes
      set -g pane-border-style fg="${thm_gray}"
      set -g pane-active-border-style fg="${thm_blue}"

      # Clock
      setw -g clock-mode-colour "${thm_blue}"
    '';

    plugins = with pkgs; [
      # Vim-tmux-navigator for seamless navigation
      tmuxPlugins.vim-tmux-navigator

      # Yank for improved clipboard
      tmuxPlugins.yank

      # Which-key for keybind hints
      tmuxPlugins.tmux-which-key

      # Mode indicator
      tmuxPlugins.mode-indicator

      # Battery status
      tmuxPlugins.battery

      # Copycat for enhanced search
      tmuxPlugins.copycat

      # Pain control
      tmuxPlugins.pain-control

      # Open URLs/files
      tmuxPlugins.open

      # CPU/Memory monitoring
      tmuxPlugins.cpu

      # Net speed monitoring
      tmuxPlugins.net-speed

      # Sensible defaults
      tmuxPlugins.sensible

      # Resurrect for session persistence
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }

      # Continuum for auto-save
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };
}
