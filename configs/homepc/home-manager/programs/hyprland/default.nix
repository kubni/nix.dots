{
  pkgs,
  lib,
  hyprland,
  hyprsplit,
  ...
}:

{

  imports = [ ./hyprpaper.nix ];
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-2,2560x1440@74.97,auto,auto"
        "HDMI-A-1,preferred,auto-left,auto"
      ];

      input = {
        touchpad = {
          natural_scroll = false;
          tap-to-click = true;
        };
      };

      general.allow_tearing = true;
      windowrule = [
        "match:class cs2, immediate on"
        "match:class horizonzerodawnremastered.exe, immediate on"
      ];

      misc = {
        force_default_wallpaper = "0";
      };

      device = {
         name = "logitech-g403-prodigy-gaming-mouse";
         accel_profile ="flat";
       };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
