{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    claude-desktop-fhs
    bubblewrap
    socat
    virtiofsd
  ];
}
