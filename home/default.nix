{ config, pkgs, ... }:

{
  home.username = "nikola";
  home.homeDirectory = "/home/nikola";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neofetch
  ];
}
