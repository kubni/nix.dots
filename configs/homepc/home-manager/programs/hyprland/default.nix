{
  pkgs,
  lib,
  hyprland,
  ...
}:

{

  imports = [ ./hyprpaper.nix ];

  wayland.windowManager.hyprland = {
    extraLuaFiles."bindings-homepc" = {
      content = ./lua/bindings-homepc.lua;
      autoLoad = true;
    };

    settings = {
      monitor = [
        {
          output = "DP-2";
          mode = "2560x1440@74.97";
          position = "auto";
          scale = "auto";
        }
        {
          output = "HDMI-A-1";
          mode = "preferred";
          position = "auto-left";
          scale = "auto";
        }
      ];

      config = {
        input.touchpad = {
          natural_scroll = false;
        };

        general.allow_tearing = true;

        misc.force_default_wallpaper = 0;
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

      device = {
        name = "logitech-g403-prodigy-gaming-mouse";
        accel_profile = "flat";
      };
    };
  };
}
