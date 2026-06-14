{ config, pkgs, ... }:

{
  imports = [
    ../../shared/by-pcs/home-manager
    ./programs
  ];

  home.stateVersion = "24.05";
}
