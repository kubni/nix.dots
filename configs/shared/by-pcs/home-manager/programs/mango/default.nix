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
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      noctalia &
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
      monitor_rule = [
        "name:^DP-2$,width:2560,height:1440,refresh:74.97,x:1920,y:0"
        "name:^HDMI-A-1$,width:1920,height:1080,refresh:60,x:0,y:0"

      ];
      mouse_accel_profile = 1;
      mouse_accel_speed = 0.0;
      cursor_size = 40;
      cursor_theme = "Nordzy-cursors-white";

      focus_color = "0x88C0D0ff"; # nord8
      border_color = "0x4C566Aff"; # nord3
      urgent_color = "0xBF616Aff"; # nord11
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];
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

        # tags
        "SUPER,1,view,1,0"
        "SUPER,2,view,2,0"
        "SUPER,3,view,3,0"
        "SUPER,4,view,4,0"
        "SUPER,5,view,5,0"
        "SUPER,6,view,6,0"
        "SUPER,7,view,7,0"
        "SUPER,8,view,8,0"
        "SUPER,9,view,9,0"

        "SUPER+SHIFT,1,tag,1,0"
        "SUPER+SHIFT,2,tag,2,0"
        "SUPER+SHIFT,3,tag,3,0"
        "SUPER+SHIFT,4,tag,4,0"
        "SUPER+SHIFT,5,tag,5,0"
        "SUPER+SHIFT,6,tag,6,0"
        "SUPER+SHIFT,7,tag,7,0"
        "SUPER+SHIFT,8,tag,8,0"
        "SUPER+SHIFT,9,tag,9,0"

      ];
    };
  };
}
