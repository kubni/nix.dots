{ config, pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home.username = "nikola";
  home.homeDirectory = "/home/nikola";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
