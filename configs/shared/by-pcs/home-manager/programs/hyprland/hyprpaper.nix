{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor="eDP-1";
          path="/home/nikola/Wallpapers/snowflake.png";
        }
        {
          monitor="HDMI-A-1";
          path="/home/nikola/Wallpapers/snowflake.png";
        }
      ];
    };
  };
}
