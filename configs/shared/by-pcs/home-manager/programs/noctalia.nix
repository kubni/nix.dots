{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Nord";
      };

      brightness = {
        enable_ddcutil = true;
        monitor.DP-2.backend = "ddcutil";
        monitor.HDMI-A-1.backend = "backlight";
      };

      bar = {
        main = {
          position = "right";
          enabled = true;
          widget_spacing = 18;
          margin_edge = 0;
          margin_ends = 0;
          scale = 1.5;
          thickness = 60;
          radius = 0;
          # background_opacity = 0.0;

          start = [
            "clock"
            "battery"
            "notifications"
          ];

          center = [
            {
              type = "workspaces";
              show_all_outputs = true;
            }
          ];
          end = [
            "media"
            "clipboard"
            "bluetooth"
            "volume"
            "brightness"
            "control-center"
            "tray"
          ];
        };
      };

      wallpaper = {
        enabled = true;
        default.path = "~/Wallpapers/2b.png";
      };
    };
  };

}
