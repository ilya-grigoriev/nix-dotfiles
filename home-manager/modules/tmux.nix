{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      set -s default-terminal 'tmux-256color'

      set -g prefix C-a
      set-option -g mouse on

      # Clipboard
      if-shell "uname | grep -q Darwin" {
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
      bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
      } {
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      }

      # Pane navigation
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2
      bind -r - split-window -v
      bind -r + split-window -h
      bind q killp

      # Status bar
      set -g status-position bottom
      set-option -g automatic-rename on
      set-option -g status-interval 1
      set -g status-bg black
      set -g status-fg white
      set -g window-status-current-style 'fg=black,bg=green'

      # Vim moves
      setw -g mode-keys vi

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind -n C-h previous-window
      bind -n C-l next-window
    '';
  };
}
