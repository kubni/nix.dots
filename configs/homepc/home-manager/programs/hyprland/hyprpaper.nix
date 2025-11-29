{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
      "/home/nikola/Wallpapers/2b.png"
      ];
      wallpaper = [
	"DP-2,/home/nikola/Wallpapers/2b.png"
	"HDMI-A-1,/home/nikola/Wallpapers/2b.png"
      ];
    };
  };
}
