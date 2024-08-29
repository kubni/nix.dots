{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
	"/home/nikola/Wallpapers/frieren.webp"
      ];
      wallpaper = [
	"DP-2,/home/nikola/Wallpapers/frieren.webp"
	"HDMI-A-1,/home/nikola/Wallpapers/frieren.webp"
      ];
    };
  };
}
