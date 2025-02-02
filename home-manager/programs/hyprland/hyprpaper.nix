{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
      "/home/nikola/Wallpapers/torii.jpg"
      ];
      wallpaper = [
	"DP-3,/home/nikola/Wallpapers/torii.jpg"
	"HDMI-A-1,/home/nikola/Wallpapers/torii.jpg"
      ];
    };
  };
}
