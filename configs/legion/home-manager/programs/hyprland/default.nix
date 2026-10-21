{
  pkgs,
  lib,
  hyprland,
  ...
}:

{
  imports = [
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    extraLuaFiles."bindings-legion" = {
      content = ./lua/bindings-legion.lua;
      autoLoad = true;
    };

    settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "2560x1600@240.00";
          position = "auto";
          scale = "auto";
        }
        {
          output = "HDMI-A-1";
          mode = "2560x1440@74.97";
          position = "auto-up";
          scale = "auto";
        }
      ];

      config = {
        input.touchpad = {
          natural_scroll = false;
        };

        general.allow_tearing = true;

        misc = {
          force_default_wallpaper = 0;
          enable_swallow = true;
          swallow_regex = "^(kitty)$";
        };

        cursor.no_hardware_cursors = true;
      };

      window_rule = [
        {
          name = "immediate-cs2";
          match.class = "cs2";
          immediate = true;
        }
        {
          name = "immediate-horizonzerodawn";
          match.class = "horizonzerodawnremastered.exe";
          immediate = true;
        }
      ];
    };
  };
}
