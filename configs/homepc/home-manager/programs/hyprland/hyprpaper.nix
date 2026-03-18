{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
	  monitor="DP-2";
          path="/home/nikola/Wallpapers/2b.png";
        }
        {
	  monitor="HDMI-A-1";
          path="/home/nikola/Wallpapers/2b.png";
        }
      ];
    };
  };
}
