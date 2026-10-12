{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./programs
  ];

  home.username = "nikola";
  home.homeDirectory = "/home/nikola";
  home.pointerCursor = {
    enable = true;
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors-white";
    size = 40;
    gtk.enable = true;
  };

  programs.home-manager.enable = true;

}
