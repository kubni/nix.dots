{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./packages
    ./zsh.nix
    ./nvf.nix
    ./tmux.nix
    ./system.nix
    ./fonts.nix
  ];

}
