{
  inputs,
  pkgs,
  ...
}: let
  tmuxConf = pkgs.writeText "tmux.conf" ''
    set -g base-index 1
    set -g mouse on
    set -g escape-time 0
    set -g mode-keys vi
    set -g default-terminal "screen-256color"
    set -as terminal-features ",alacritty*:RGB"

    set -g allow-rename on
    set -g set-titles on
    set -g set-titles-string '#t'

    # Reload config
    bind -n M-r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

    # Window navigation
    bind C-p previous-window
    bind C-n next-window
    bind c new-window -c "#{pane_current_path}"
    bind -n C-1 select-window -t 1
    bind -n C-2 select-window -t 2
    bind -n C-3 select-window -t 3
    bind -n C-4 select-window -t 4
    bind -n C-5 select-window -t 5
    bind -n C-6 select-window -t 6
    bind -n C-7 select-window -t 7
    bind -n C-8 select-window -t 8
    bind -n C-9 select-window -t 9

    # Pane navigation
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # Pane resize
    bind -n M-S-Left resize-pane -L 5
    bind -n M-S-Right resize-pane -R 5
    bind -n M-S-Up resize-pane -U 3
    bind -n M-S-Down resize-pane -D 3

    # Splits
    bind '-' split-window -c "#{pane_current_path}"
    unbind .
    bind . split-window -h -c "#{pane_current_path}"

    # Kill
    bind x kill-pane
    bind e kill-window
    bind -n M-Q kill-session

    # Copy mode
    setw -g mode-keys vi
    set -g status-keys vi
    bind-key -T copy-mode-vi 'y' send -X begin-selection
    bind-key -T copy-mode-vi 'y' send -X copy-selection

    # Prefix
    unbind-key C-b
    set -g prefix M-a
    bind-key M-a send-prefix

    # Plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-yank'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    set -g @plugin 'tmux-plugins/tmux-copycat'
    set -g @plugin 'tmux-plugins/tmux-cpu'
    set -g @plugin 'tmux-plugins/tmux-net-speed'
    set -g @plugin 'tmux-plugins/tmux-battery'
    set -g @plugin 'tmux-plugins/tmux-mode-indicator'
    set -g @plugin 'jimeh/tmux-gruvbox-theme'
    set -g @plugin 'christoomey/vim-tmux-navigator'

    run '~/.tmux/plugins/tpm/tpm'
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.tmux = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.tmux;
      env = {
        TMUX_CONF = tmuxConf;
      };
    };
  };
}
