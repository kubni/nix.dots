{
  config,
  lib,
  pkgs,
  ...
}:

{

  fonts.packages = with pkgs; [
    commit-mono
    atkinson-hyperlegible
    nerd-fonts.symbols-only
    intel-one-mono
  ];
}
