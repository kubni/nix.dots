{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
	"/home/nikola/Wallpapers/frieren.webp"
  "/home/nikola/Wallpapers/moon.webp"
  "/home/nikola/Wallpapers/astronaut-nord.png"
      ];
      wallpaper = [
	"DP-3,/home/nikola/Wallpapers/astronaut-nord.png"
	"HDMI-A-1,/home/nikola/Wallpapers/moon.webp"
      ];
    };
  };
}
