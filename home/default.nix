{ config, pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home.username = "nikola";
  home.homeDirectory = "/home/nikola";
  home.stateVersion = "23.05";

  # Custom options
  home.file.".xinitrc".source = ./xinitrc;

  programs.home-manager.enable = true;
}
