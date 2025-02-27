{ config, pkgs, inputs, username, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig =
      # conf
      ''
        # remap prefix from 'C-b' to 'C-a'
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # rename window
        bind-key r command-prompt -I "#W" "rename-window '%%'"

        # Start windows and panes at 1, not 0
        set -g base-index 1
        setw -g pane-base-index 1

        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
        bind -n M-s select-pane -L
        bind -n M-f select-pane -R
        bind -n M-e select-pane -U
        bind -n M-d select-pane -D

        # don't rename windows automatically
        set-option -g allow-rename off

        # Enable mouse control (clickable windows, panes, resizable panes)
        set -g mouse on

        set -g allow-passthrough on
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"
        # DESIGN TWEAKS

        # don't do anything when a 'bell' rings
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        # clock mode
        setw -g clock-mode-colour colour1

        # copy mode
        setw -g mode-style 'fg=colour1 bg=colour18 bold'

        # pane borders
        set -g pane-border-style 'fg=colour6'
        set -g pane-active-border-style 'fg=colour4'

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'fg=colour2'
        set -g status-left ' '
        set -g status-right ' '
        #set -g status-right '%Y-%m-%d %H:%M '
        set -g status-right-length 50
        set -g status-left-length 10

        setw -g window-status-current-style 'fg=colour0 bg=colour6 bold'
        setw -g window-status-current-format ' #I #W #F '

        setw -g window-status-style 'fg=colour6 dim'
        setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour6]#F '

        setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

        # messages
        set -g message-style 'fg=colour2 bg=colour0 bold'
      '';
  };
}