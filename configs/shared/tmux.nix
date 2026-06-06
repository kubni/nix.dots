{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-direct";   # better color support
    plugins = [ pkgs.tmuxPlugins.nord ];
    extraConfig = ''
      set -g mouse on
      setw -g mode-keys vi
      set-option -g allow-rename off

      # visible copy-mode selection
      set -g mode-style 'bg=blue,fg=black'


      # Design tweaks
      ## Don't do anything when a 'bell' rings
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # clock mode
      setw -g clock-mode-colour yellow

      # statusbar
      set -g status-style 'bg=brightblack,fg=white'
      set -g status-position bottom
      set -g status-justify left

      set -g status-left-length 10

      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50

      setw -g window-status-current-format ' #I #W #F '
    '';
  };
}
