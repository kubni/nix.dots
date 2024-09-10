{ config, pkgs, ... }:

{
  imports = [
    ./programs
    ./dconf.nix
  ];

  home.username = "nikola";
  home.homeDirectory = "/home/nikola";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
