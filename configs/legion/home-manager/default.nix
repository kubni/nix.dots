{ config, pkgs, ... }:

{
  imports = [
    ../../shared/by-pcs/home-manager
    ./programs
  ];

  home.stateVersion = "24.05"; # TODO: Different from the configuration.nix value !
}
