{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
      "/home/nikola/Wallpapers/torii.jpg"
      "/home/nikola/Wallpapers/2b.jpeg"
      ];
      wallpaper = [
	"DP-3,/home/nikola/Wallpapers/2b.jpeg"
	"HDMI-A-1,/home/nikola/Wallpapers/2b.jpeg"
      ];
    };
  };
}
