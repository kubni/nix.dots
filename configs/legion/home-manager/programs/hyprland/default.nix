{
  pkgs,
  lib,
  hyprland,
  hyprsplit,
  ...
}:

{
  imports = [
    ./hyprpaper.nix
  ];
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1,2560x1600@240.00,auto,auto"
        "HDMI-A-1,2560x1440@74.97,auto-up,auto"
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
        enable_swallow = "true";
        swallow_regex = "^(kitty)$";
      };

      cursor = {
        no_hardware_cursors = "true";
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
