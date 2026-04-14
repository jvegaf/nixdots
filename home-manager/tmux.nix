{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = ''
      set -as terminal-features ",alacritty*:RGB"
      bind -n M-r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind C-p previous-window
      bind C-n next-window

      unbind-key C-b
      set -g prefix M-a
      bind-key M-a send-prefix

      set-option -g allow-rename on
      set-option -g set-titles on
      set-option -g set-titles-string '#t'

      bind -n C-1 select-window -t 1
      bind -n C-2 select-window -t 2
      bind -n C-3 select-window -t 3
      bind -n C-4 select-window -t 4
      bind -n C-5 select-window -t 5
      bind -n C-6 select-window -t 6
      bind -n C-7 select-window -t 7
      bind -n C-8 select-window -t 8
      bind -n C-9 select-window -t 9

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Up resize-pane -U 3
      bind -n M-S-Down resize-pane -D 3

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      unbind .
      bind . split-window -h -c "#{pane_current_path}"

      bind x kill-pane
      bind e kill-window
      bind -n M-Q kill-session

      setw -g mode-keys vi
      set -g status-keys vi
      bind-key -T  copy-mode-vi 'y' send -X begin-selection # start selecting text whith "v"
      bind-key -T  copy-mode-vi 'y' send -X copy-selection # copy text whith "v"

    '';
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.tmux-which-key
      tmuxPlugins.mode-indicator
      tmuxPlugins.battery
      tmuxPlugins.continuum
      tmuxPlugins.copycat
      tmuxPlugins.cpu
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.net-speed

      # {
      #   plugin = tmuxPlugins.resurrect;
      #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      # }
      # {
      #   plugin = tmuxPlugins.continuum;
      #   extraConfig = ''
      # set -g @continuum-restore 'on'
      # set -g @continuum-save-interval '60' # minutes
      #   '';
      # }
    ];
  };
}
