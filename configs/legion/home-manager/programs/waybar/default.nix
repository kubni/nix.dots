{config, pkgs, lib, ...}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = builtins.readFile ./style.css;
  };

  xdg.configFile."waybar/config".source = ./config.json;
}
