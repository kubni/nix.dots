{
  pkgs,
  lib,
  split-monitor-workspaces,
  ...
}:

let
  inherit (lib.generators) mkLuaInline;
in
{
  xdg.configFile."hypr/plugins/split-monitor-workspaces".source = split-monitor-workspaces;
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";

    extraLuaFiles = {
      "lib.vars" = {
        content = ./lua/vars.lua;
        autoLoad = false;
      };
      "bindings" = {
        content = ./lua/bindings.lua;
        autoLoad = true;
      };
    };

    settings = {
      config = {
        debug.disable_logs = true;

        input = {
          kb_layout = "us,rs,";
          kb_variant = ",latin";
          kb_model = ",qwerty";
          kb_options = "grp:alt_shift_toggle";

          follow_mouse = 1;
          sensitivity = 0;
        };

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 2;

          layout = "master";
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };

        animations.enabled = true;

        dwindle.preserve_split = true;

        master.new_status = "master";
      };

      curve = [
        {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "myBezier";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = false;
        }
      ];

      env = [
        {
          _args = [
            "HYPRCURSOR_THEME"
            "Nordzy-hyprcursors-white"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "40"
          ];
        }
        {
          _args = [
            "QT_QPA_PLATFORM"
            "wayland;xcb"
          ];
        }
        {
          _args = [
            "QT_QPA_PLATFORMTHEME"
            "qt6ct"
          ];
        }
      ];

      # TODO: Check whether Mako works
      on = {
        _args = [
          "hyprland.start"
          (mkLuaInline ''
            function()
              -- hl.exec_cmd("mako &")
              hl.exec_cmd("noctalia &")
              hl.exec_cmd("wl-paste --type text --watch cliphist store")
              hl.exec_cmd("wl-paste --type image --watch cliphist store")
            end'')
        ];
      };
    };
  };
}
