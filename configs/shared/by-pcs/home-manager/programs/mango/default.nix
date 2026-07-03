{
  config,
  lib,
  pkgs,
  ...
}:
let
  clipMenu = pkgs.writeShellScript "clip-menu" ''
    cliphist list | wofi --dmenu | cliphist decode | wl-copy
  '';
  screenshotArea = pkgs.writeShellScript "screenshot-area" ''
    mkdir -p "$HOME/Screenshots"
    grim -g "$(slurp)" - | wl-copy \
      && wl-paste > "$HOME/Screenshots/Screenshot-$(date +%F_%T).png"
    notify-send -t 1000 "Screenshot of the region taken"
  '';
  screenshotFull = pkgs.writeShellScript "screenshot-full" ''
    mkdir -p "$HOME/Screenshots"
    grim - | wl-copy \
      && wl-paste > "$HOME/Screenshots/Screenshot-$(date +%F_%T).png"
    notify-send -t 1000 "Screenshot of the whole screen taken"
  '';
in
{
  wayland.windowManager.mango = {
    enable = true;
    autostart_sh = ''
      mako &
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    '';
    settings = {
      animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_duration_open = 400;
      animation_duration_close = 800;
      animation_curve = {
        open = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
      };
      bind = [
        # window management
        "SUPER,Q,killclient"
        "SUPER+SHIFT,Q,quit"
        "SUPER+SHIFT,F,togglefullscreen"
        "SUPER,T,togglefloating"
        "SUPER,J,switch_layout"

        # launchers
        "SUPER,Return,spawn,wezterm"
        "SUPER,F,spawn,firefox"
        "SUPER,D,spawn,wofi --show drun"
        "SUPER,E,spawn,emacs"
        "SUPER,V,spawn,${clipMenu}"

        # focus movement
        "SUPER,Left,focusdir,left"
        "SUPER,Right,focusdir,right"
        "SUPER,Up,focusdir,up"
        "SUPER,Down,focusdir,down"

        # alt spawns
        "ALT,F,spawn,wezterm start ranger"
        "ALT,P,spawn,wezterm start pulsemixer"

        # screenshots
        "NONE,Print,spawn,${screenshotArea}"
        "SHIFT,Print,spawn,${screenshotFull}"
      ];
    };
  };
}
