{pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
#	"/home/nikola/Wallpapers/frieren.webp"
  "/home/nikola/Wallpapers/nix.png"
      ];
      wallpaper = [
	"eDP-1,/home/nikola/Wallpapers/nix.png"
	"HDMI-A-1,/home/nikola/Wallpapers/nix.png"
      ];
    };
  };
}
