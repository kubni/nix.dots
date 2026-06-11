{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./waybar
    ./terminals
    ./mako.nix
    ./direnv.nix
    ./browsers.nix
    ./dconf.nix
  ];
}
