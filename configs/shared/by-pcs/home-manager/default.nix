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

  programs.home-manager.enable = true;

}
